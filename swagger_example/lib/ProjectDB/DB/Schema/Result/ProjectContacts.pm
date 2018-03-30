package ProjectDB::DB::Schema::Result::ProjectContacts;
    
use strict;
use warnings;
use base qw(DBIx::Class);

our $VERSION = 1;

__PACKAGE__->load_components( qw/PK::Auto Core/ );
__PACKAGE__->table( 'project_contacts' );
__PACKAGE__->add_columns(
    project_id => {
        data_type          => 'INT',
        is_numeric         => 1,
        retrieve_on_insert => 1,
        is_foreign_key     => 1,
    },
    contact_id => {
        data_type          => 'BIGINT',
        is_numeric         => 1,
        retrieve_on_insert => 1,
        is_foreign_key     => 1,
    },

);
__PACKAGE__->set_primary_key( qw/ project_id contact_id / );



__PACKAGE__->belongs_to(project => 'ProjectDB::DB::Schema::Result::Project',
             { 'foreign.id' => 'self.project_id' });

__PACKAGE__->belongs_to(contacts => 'ProjectDB::DB::Schema::Result::Contacts',
             { 'foreign.contact_id' => 'self.contact_id' });



sub sqlt_deploy_hook {
    my ($self, $table) = @_;

    $table->add_index(
        type   => "normal",
        name   => "fk_project_has_contacts_contacts1_idx",
        fields => ['contact_id'],
    );

    $table->add_index(
        type   => "normal",
        name   => "fk_project_has_contacts_project1_idx",
        fields => ['project_id'],
    );

}


1;