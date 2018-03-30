#!/usr/bin/perl

use v5.10;

use strict;
use warnings;

use File::Basename;

use lib dirname(__FILE__) . '/lib';
use lib 'lib';

use My::GraphQL::GUI;

my $tool = My::GraphQL::GUI->new;
$tool->MainLoop;

1;
