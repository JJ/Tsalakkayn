#!/usr/bin/env perl

use strict;
use warnings;

use v5.12;

my $puntuacion = qr/[:;,.\(\)\?\!]/;
my $file = join( "", <>); #lee de entrada estándar o línea de órdenes
$file =~ s/\s+/ /g;
$file =~ s/¿-_//g;
my @frases = split($puntuacion, $file );

my %frecuencias;
for my $f (@frases) {
    my $esta_frase = lcfirst $f;
    my @palabras = split(/\s+/, $esta_frase);
    for my $p (@palabras) {
	$frecuencias{$p}++
    }
}

for my $p ( sort { $frecuencias{$b} <=> $frecuencias{$a} } keys %frecuencias ) {
    say "$p => $frecuencias{$p}"
}
