use strict;
use warnings;
use v5.19.1;

open(FILE, '<', "19.txt") or die $!;
my @l = split "\n\n", join "", <FILE>;
$l[0] = [map { s/.*: |//r } sort { ($a =~ s/:.*//r) <=> ($b =~ s/:.*//r) } split "\n", $l[0] =~ tr/\"//d ];
close(FILE);

while($l[0][0] =~ s/\s*(\b\d+\b)\s*/"(".($l[0][$1]).")"/eg) {}
say $l[1] =~ s/^$l[0][0]$//gm;
