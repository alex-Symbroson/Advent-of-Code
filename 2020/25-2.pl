use strict;
use warnings;
use v5.25.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

open(FILE, '<', "25.txt") or die $!;
my @m = (0, 0, 0, 1);
my $t = 0;
map { $m[$_ - $t]++; $t = $_ } sort { $a <=> $b } <FILE>;
close(FILE);
say $m[1]*$m[3];
