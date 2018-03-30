#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Spec;
use MySQL::Workbench::SQLiteSimple;

my $base_dir = File::Spec->rel2abs( File::Spec->catdir( dirname( __FILE__ ), '..' ) );
my $mwb_file = File::Spec->catfile( $base_dir, 'docs', 'glue.mwb' );
my $out_dir  = File::Spec->catdir( $base_dir, 'lib' );
 
my $foo = MySQL::Workbench::SQLiteSimple->new(
    file        => $mwb_file,
    output_path => File::Spec->catdir( $base_dir, 'docs' ),
);
 
$foo->create_sql;

