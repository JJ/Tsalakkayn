#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp qw( read_file write_file);
use v5.12;

my $file_name = shift || "Tsalakkayn.md";

my $file = read_file($file_name) || die "No puedo abrir $file_name por $!\n";

my $puntuacion = qr/[:;,.\(\)\?\!]/;

$file =~ s/\s+/ /g;
$file =~ s/[-_*»¡¿]//g;
$file =~ s/[^\x00-\xFF]//g; # Sugerido por http://stackoverflow.com/questions/10437455/perl-stop-print-if-wide-characters-error, elimina interrogaciones y eso
my @frases = split($puntuacion, $file );

my %frecuencias;
for my $f (@frases) {
    my $esta_frase = lcfirst $f;
    my @palabras = split(/\s+/, $esta_frase);
    for my $p (@palabras) {      
	$frecuencias{$p}++ if $p;
    }
}

my ( $name, $ext) = split(/\./, $file_name);
open my $frecuencias_fh, ">", "$name.frecuencias.dat";
open my $palabras_fh, ">", "$name.palabras.dat";
open my $nombres_fh, ">", "$name.nombres.dat";
for my $p ( sort { $frecuencias{$b} <=> $frecuencias{$a} } keys %frecuencias ) {
    say $frecuencias_fh "$p => $frecuencias{$p}";
    say $nombres_fh $p if $p !~ /^[a-z]/;
    say $palabras_fh $p;
}
close $frecuencias_fh;
close $palabras_fh;
close $nombres_fh;
