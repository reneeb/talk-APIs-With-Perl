package APIs::With::Perl::Plugin::DB;

use v5.20;

use Mojo::Base 'Mojolicious::Plugin';
use Mojo::JWT;

use DBI;

sub register {
    my ($self, $app, $conf) = @_;

    my $db = DBI->connect( 'DBI:SQLite:' . $app->config->{db} );

    $app->helper( db    => sub { $db } );
    $app->helper( login => sub {
        my $c = shift;

        my $sql = 'SELECT password FROM app_users WHERE username = ?';
        my $sth = $c->db->prepare( $sql );
        $sth->execute( $c->param('username') );
        
        my $password;
        while ( my ($pwd) = $sth->fetchrow_array ) {
             $password = $pwd;
        }

        return if !$password;

        # TODO
        return if !$verified;
    });

    $app->helper( events => sub {
        my $c = shift;

        my $sql = 'SELECT uuid, name, date_from, date_to FROM events WHERE username = ?';
        my $sth = $c->db->prepare( $sql );
        $sth->execute( $c->username );

        my @events;
        while ( my ($uuid, $name, $from, $to) = $sth->fetchrow_array ) {
            push @events, {
                uuid => $uuid,
                name => $name,
                from => $from,
                to   => $to,
            };
        }

        return @events;
    });

    $app->helper( talks => sub {
        my $c        = shift;
        my $event_id = shift;

        my $sql = 'SELECT uuid, title, talk_date FROM events WHERE username = ?';

        my @binds;
        if ( $event_id ) {
            $sql .= ' AND event_id = ?';
            push @binds, $event_id;
        }

        my $sth = $c->db->prepare( $sql );
        $sth->execute( $c->username, @binds );

        my @talks;
        while ( my ($uuid, $title, $date) = $sth->fetchrow_array ) {
            push @talks, {
                uuid  => $uuid,
                title => $title,
                date  => $date,
            };
        }

        return @talks;
    });

    $app->helper( username => sub {
        my $c      = shift;
        my $claims = $c->get_jwt;

        return $claims->{username};
    });

    $app->helper( check_session => sub {
        my $c      = shift;
        my $claims = $c->get_jwt;

        my $sql_select = q~
            SELECT session_id
            FROM sessions
            WHERE username = ?
                AND session_id = ?
                AND expires > NOW()
        ~;

        my $sth = $c->db->prepare( $sql_select );
        $sth->execute(
            $claims->{username},
            $claims->{session_id}
        );

        my $session_id;
        while ( my ($id) = $sth->fetchrow_array ) {
            $session_id = $id;
        }

        my $sql_update = q~
            UPDATE sessions
            SET expires = NOW() + 1200
            WHERE session_id = ?
        ~;
        $c->db->do( $sql_update );

        return 1 if $session_id;
        return 0;
    });

    $app->helper( get_jwt => sub {
        my $c   = shift;
        my $jwt = $c->param('jwt');

        my $claims = Mojo::JWT->new(
            secret => $app->config->{jwt_secret}
        )->decode( $jwt );

        return $claims;
    });
}

1;
