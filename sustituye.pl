#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use File::Slurp qw( read_file write_file);
use v5.12;

my $procesa_file = shift || "Tsalakkayn.nombres.dat";
my $sust_file = "sustituciones.dat";

my @sustituciones_lineas = read_file($sust_file);

#Sustituciones gracias a http://stackoverflow.com/questions/392643/how-to-use-a-variable-in-the-replacement-side-of-the-perl-substitution-operator
my @sustituciones;
for my $s (@sustituciones_lineas) {
    my ($lhs, $rhs) = split( /\s+/, $s );
    push @sustituciones, [ $lhs, '"'.$rhs.'"'] if $lhs;
}

my @sorted_sust = sort { length( $b->[0] ) <=> length( $a->[0] ) } @sustituciones;
			 
my @nombres = read_file($procesa_file);

for my $n (@nombres) {
  chop $n;
  my $newspeak = lcfirst $n;
  for my $s (@sorted_sust) {
    $newspeak =~ s/$s->[0]/$s->[1]/gee;
  }
  say "$n ".ucfirst($newspeak);
}
