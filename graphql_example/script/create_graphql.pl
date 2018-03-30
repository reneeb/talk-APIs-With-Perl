#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib', '../lib';
use File::Basename;

use GraphQL::Plugin::Convert::DBIC;
use ProjectDB::DB::Schema;
my $converted = GraphQL::Plugin::Convert::DBIC->to_graphql(
  sub { ProjectDB::DB::Schema->connect( dirname(__FILE__) . '/../project.db') }
);
print $converted->{schema}->to_doc;
