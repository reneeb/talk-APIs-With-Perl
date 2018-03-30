package ProjectDB::DB::Schema::Result::Project;
    
use strict;
use warnings;
use base qw(DBIx::Class);

our $VERSION = 1;

__PACKAGE__->load_components( qw/PK::Auto Core/ );
__PACKAGE__->table( 'project' );
__PACKAGE__->add_columns(
    id => {
        data_type          => 'INT',
        is_auto_increment  => 1,
        is_numeric         => 1,
        retrieve_on_insert => 1,
    },
    start_date => {
        data_type          => 'DATETIME',
    },
    end_date => {
        data_type          => 'DATETIME',
        is_nullable        => 1,
    },
    shortname => {
        data_type          => 'VARCHAR',
        size               => 45,
    },
    abbreviation => {
        data_type          => 'VARCHAR',
        size               => 45,
    },
    description => {
        data_type          => 'MEDIUMTEXT',
        is_nullable        => 1,
    },
    projectnumber => {
        data_type          => 'VARCHAR',
        size               => 15,
    },

);
__PACKAGE__->set_primary_key( qw/ id / );


__PACKAGE__->has_many(project_contacts => 'ProjectDB::DB::Schema::Result::ProjectContacts',
             { 'foreign.project_id' => 'self.id' });





1;