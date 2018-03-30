package ProjectDB;
use Mojo::Base 'Mojolicious';

use ProjectDB::DB::Schema;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  $self->app->helper(
      db => sub {
          ProjectDB::DB::Schema->connect('DBI:SQLite:/home/otrsvm/project.db');
      }
  );

  $self->plugin( GraphQL => {
      convert  => [ 'DBIC', sub { $self->db } ],
      graphiql => 1,
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
