requires "DBIx::Class" => "0";
# TODO - update Yancy to version with DBIx::Class::Yancy support
requires "Yancy" => "1.018";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "DBD::SQLite" => "0";
  requires "DBIx::Class" => "0";
  requires "Mojolicious" => "0";
  requires "Test::More" => "1.001005";
};
