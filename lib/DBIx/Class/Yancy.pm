package DBIx::Class::Yancy;

# PODNAME: DBIx::Class::Yancy
# ABSTRACT: Set Yancy collection config through DBIx::Class result classes

use strict;
use warnings;
use base qw( DBIx::Class );

use namespace::clean;

our $VERSION = '0.001';

=head1 NAME

DBIx::Class::Yancy - Set Yancy collection config through DBIx::Class result classes

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

L<Yancy> is a simple content management system (CMS) for administering content
in a database. Yancy accepts a configuration file that describes the data in
the database and builds a website that lists all of the available data and
allows a user to edit data, delete data, and add new data.

=head1 SEE ALSO

L<Yancy>, L<DBIx::Class>

=cut

__PACKAGE__->mk_classdata( 'yancy' => {'x-ignore' => 1} );


=head1 AUTHOR

Mario Minati <mario.minati@minati.de>

=head1 CONTRIBUTORS

=for stopwords Doug Bell

=over 4

=item *

Doug Bell <preaction@cpan.org> (Testing code inspired by L<Yancy>)

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Mario Minati and Minati Engineering GmbH & Co. KG.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

1;
