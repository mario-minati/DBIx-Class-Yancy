package Local::DbicYancySchema::Result::people;

use Mojo::Base '-strict';
use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw(Yancy));

__PACKAGE__->table('people');
__PACKAGE__->add_columns(
    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },
    qw/ name /,
    email => {
        is_nullable => 1,
    },
);
__PACKAGE__->set_primary_key('id');


__PACKAGE__->yancy({
  title => "my important people",
  'x-id-field' => 'email',
  'x-list-columns' => [
      { title => "Person", template => '{name} <{email}>' },
  ],
});
1;
