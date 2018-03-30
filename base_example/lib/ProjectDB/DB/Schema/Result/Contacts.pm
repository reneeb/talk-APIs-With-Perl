package ProjectDB::DB::Schema::Result::Contacts;
    
use strict;
use warnings;
use base qw(DBIx::Class);

our $VERSION = 1;

__PACKAGE__->load_components( qw/PK::Auto Core/ );
__PACKAGE__->table( 'contacts' );
__PACKAGE__->add_columns(
    contact_id => {
        data_type          => 'BIGINT',
        is_auto_increment  => 1,
        is_numeric         => 1,
        retrieve_on_insert => 1,
    },
    contact_name => {
        data_type          => 'VARCHAR',
        size               => 255,
    },
    address => {
        data_type          => 'VARCHAR',
        is_nullable        => 1,
        size               => 255,
    },
    phone => {
        data_type          => 'VARCHAR',
        is_nullable        => 1,
        size               => 45,
    },
    email => {
        data_type          => 'VARCHAR',
        is_nullable        => 1,
        size               => 255,
    },
    mobile => {
        data_type          => 'VARCHAR',
        is_nullable        => 1,
        size               => 45,
    },

);
__PACKAGE__->set_primary_key( qw/ contact_id / );


__PACKAGE__->has_many(project_contacts => 'ProjectDB::DB::Schema::Result::ProjectContacts',
             { 'foreign.contact_id' => 'self.contact_id' });





1;