use strict;
use warnings;
use v5.19.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

open(FILE, '<', "19.txt") or die $!;
my @l = split "\n\n", join "", <FILE>;
$l[0] = [map { s/.*: |//r } sort { ($a =~ s/:.*//r) <=> ($b =~ s/:.*//r) } split "\n", $l[0] =~ s/"//gr ];
close(FILE);

$l[0][8] = "42+";
$l[0][11] = "42 31 | 42 42 31 31 | 42 42 42 31 31 31 | 42 42 42 42 31 31 31 31";

while($l[0][0] =~ s/\s*(\b\d+\b)\s*/"(".($l[0][$1]).")"/eg) {}
say $l[1] =~ s/^$l[0][0]$//gm;

# $l[0][8] = "42+";
# $l[0][11] = "42 11 31";
#
# while(2 < ($l[0][0] =~ s/\s*(\b\d+\b)\s*/"(".($l[0][$1]).")"/eg)) {}
# say $l[1] =~ s/^$l[0][0]$//gm;
