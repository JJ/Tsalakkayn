#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use File::Slurp qw( read_file write_file);
use v5.12;

my $procesa_file = shift || "Tsalakkayn.md";
my $sust_file = "Tsalakkayn.solo.equivalencias.dat";

my @sustituciones_lineas = read_file($sust_file);
my @sustituciones_map;
for my $s (@sustituciones_lineas) {
    chomp $s;
    my ($palabra, $sustituto) = ($s =~ /^(\w+)\s+(.+)/);
    if ( $palabra) {
      push @sustituciones_map, [$palabra, $sustituto];
    } else {
      say "Error con $s";
    }
}

my $texto = read_file($procesa_file);

for my $s (@sustituciones_map) {
  $texto =~ s/\b$s->[0]\b/$s->[1]/g;
  my $uc_palabra = ucfirst $s->[0];
  my $uc_sustituto = ucfirst $s->[1];
  $texto =~ s/\b$uc_palabra\b/$uc_sustituto/
}
say $texto;
