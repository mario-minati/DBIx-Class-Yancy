package DBIx::Class::Yancy;
use strict;
use warnings;
use base qw( DBIx::Class );

use namespace::clean;

=head1 NAME

DBIx::Class::Yancy - Set Yancy collection config in result class.

=head1 SYNOPSIS

In your Schema or DB class add "Yancy" to the component list.

  __PACKAGE__->load_components(qw( ... Yancy ... ));

Specify the yancy collection config for the table.

  package My::Item;
  __PACKAGE__->yancy({
    title => "Fany item table",
    'x-id-field' => 'email',
    'x-list-columns' => [
        { title => "Person", template => '{name} <{email}>' },
    ],
    api_controller => 'My::Fancy::Yancy::API::Controller',
  });

All possible config options for collections are available at
L<Yancy::Help::Config>.

If you don't, specify a custom config the table will be ignored.
The default config is like:

  package My::Item;
  __PACKAGE__->yancy({
    'x-ignore' => 1,
  });

=cut

__PACKAGE__->mk_classdata( 'yancy' => {'x-ignore' => 1} );

1;
