use strict;
use warnings;
use Test::More;
$| = 1;

BEGIN {
    eval "use DBD::SQLite";
    plan $@ ? (skip_all => 'needs DBD::SQLite for testing') : (tests => 3);
    use File::Temp qw/tempfile/;
}

{
    package TestDB::Schema;
    use base qw(DBIx::Class::Schema);
    use strict;
    use warnings;

    sub create_table {
        my $class = shift;
        $class->storage->dbh_do(
            sub {
                my ($storage, $dbh, @cols) = @_;
                $dbh->do(q{
                    CREATE TABLE foo (
                        session_id VARCHAR(32) PRIMARY KEY,
                        number     INT
                    )
                });
            },
        );
    }

    1;

    package TestDB::Schema::Foo;
    use strict;
    use warnings;
    use base qw/DBIx::Class/;

    __PACKAGE__->load_components(qw/Core Yancy/);
    __PACKAGE__->table('foo');
    __PACKAGE__->add_columns(qw(session_id number));
    __PACKAGE__->set_primary_key('session_id');
    __PACKAGE__->yancy({
      title => "Fany item table",
      'x-id-field' => 'email',
      'x-list-columns' => [
          { title => "Person", template => '{name} <{email}>' },
      ],
      api_controller => 'My::Fancy::Yancy::API::Controller',
    });

    1;
}

my (undef, $DB) = tempfile();
my $schema = TestDB::Schema->connection("dbi:SQLite:dbname=$DB", '', '', { AutoCommit => 1 });
END { unlink $DB if -e $DB }

ok($schema->create_table, 'create table');

TestDB::Schema->load_classes('Foo');

my $foo = $schema->resultset('Foo')->create({number => 1});
is($foo->number, 1, 'can set number');
is_deeply($foo->yancy, {
  title => "Fany item table",
  'x-id-field' => 'email',
  'x-list-columns' => [
      { title => "Person", template => '{name} <{email}>' },
  ],
  api_controller => 'My::Fancy::Yancy::API::Controller',
}, 'yancy setting is correct');
