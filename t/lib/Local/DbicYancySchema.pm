package Local::DbicYancySchema;

use Mojo::Base '-strict';
use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces();

1;
