package My::GraphQL::GUI;

use v5.10;

use strict;
use warnings;

use Wx qw(:everything);
use Wx::Event qw(:everything);
use Wx::XRC;

use Data::Dumper;
use Data::Printer;
use File::Basename;
use File::Spec;
use JSON::PP;
use HTTP::Tiny;
use Pegex;
use URI::Encode;

our @ISA = qw(Wx::App);

our $VERSION = '0.01';

sub OnInit {
    my ( $self ) = @_;

    # --
    # handle XRC
    # --

    # the XRC handler for the tableau
    my $xrc_file = File::Spec->catfile(
        dirname( $0 ),
        'graph_ql.xrc',
    );

    die "XRC file not found" if !-f $xrc_file;

    my $xrc = Wx::XmlResource->new;
    $xrc->InitAllHandlers;
    $xrc->Load( $xrc_file );

    my $frame = $xrc->LoadFrame( undef, 'GraphQL' );

    $self->{all_xrc} = $xrc;
    $self->{GraphQL} = $frame;

    Wx::InitAllImageHandlers();

    # --
    # handle events
    # --
    my $grammar_file = File::Spec->catfile(
        dirname( $0 ),
        'graphql.pgx'
    );

    $self->{grammar} = do {
        local ( @ARGV, $/ ) = ($grammar_file);
        <>;
    };

    $self->{pegex} = pegex( $self->{grammar} );

    # -- App
    my $input = $self->get_element('graph_in');
    EVT_KEY_UP( $input, sub {
        $self->send_request( $input->GetValue() );
    });


    # finally show the GUI
    $frame->Show(1);

    1;
}

=head2 send_request

=cut

sub send_request {
    my ($self) = @_;

    my $out = $self->get_element( 'graph_out' );
    $out->SetValue('');

    my $text  = $self->get_element( 'graph_in' )->GetValue();

    eval {
        my $result = $self->{pegex}->parse( $text );
        1;
    } or return;

    $text =~ s{\A\s+}{};

    my $ua   = HTTP::Tiny->new;
    my $json = JSON::PP->new->utf8(1)->encode({ query => $text });
    my $url  = 'http://localhost:3000/graphql';

    my $method;
    if ( $text =~ m{\A(create|\{)} ) {
        $method = 'get';
    }
    elsif ( $text =~ m{\Amutation} ) {
        $method = 'post';
    }

    return if !$method;

    my $response = $ua->$method( $url, {
        header  => { 'Content-Type' => 'application/graphql' },
        content => $json,
    });

    my $json = $response->{content};

    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Indent   = 1;

    my $dump = Dumper( JSON::PP->new->utf8(1)->decode( $json ) );
    $dump    =~ s{\$VAR1 \s+ = \s+}{}xms;

    $out->AppendText( $dump );
}

=head2 get_id

returns the id that represents the widget for the given name. The name is the
name specified in the XRC file

=cut

sub get_id {
    my ($self, $name) = @_;

    my $element = Wx::XmlResource::GetXRCID( $name );

    return $element;
}

=head2 get_element

returns the object that represents the widget for the given name. The name is the
name specified in the XRC file

=cut

sub get_element {
    my ($self, $name, $window) = @_;

    $window //= 'GraphQL';

    my $element = $self->{$window}->FindWindow(
        Wx::XmlResource::GetXRCID( $name )
    );

    return $element;
}

1;
