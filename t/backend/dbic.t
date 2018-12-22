use Mojo::Base '-strict';
use Test::More;
use FindBin qw( $Bin );
use File::Spec::Functions qw( catdir );
use DBIx::Class;
use DBD::SQLite;

use lib catdir( $Bin, '..', 'lib' );
use Yancy::Backend::Dbic;

my $collections = {
    people => {
        type => 'object',
        properties => {
            id => {
                type => 'integer',
            },
            name => {
                type => 'string',
            },
            email => {
                type => 'string',
                pattern => '^[^@]+@[^@]+$',
            },
        },
    },
    user => {
        type => 'object',
        'x-id-field' => 'username',
        properties => {
            username => {
                type => 'string',
            },
        },
    },
    mojo_migrations => {
        'x-ignore' => 1,
    },
};

use Local::DbicYancySchema;
my $dbic = Local::DbicYancySchema->connect( 'dbi:SQLite::memory:' );
$dbic->deploy;
my $be;

# TODO
# - fix test to work with Yancy with DBIx::Class support

subtest 'dbic yancy settings' => sub {
    my $empty_people = $dbic->resultset('people')->new({});
    can_ok $empty_people, qw(yancy);
    is_deeply $empty_people->yancy, {
        title => "my important people",
        'x-id-field' => 'email',
        'x-list-columns' => [
            { title => "Person", template => '{name} <{email}>' },
        ],
    };

    is_deeply $dbic->resultset('user')->new({})->yancy, {
        'x-ignore' => 1,
    };

    is_deeply $dbic->resultset('mojo_migrations')->new({})->yancy, {
        'x-ignore' => 1,
    };
};

done_testing;
