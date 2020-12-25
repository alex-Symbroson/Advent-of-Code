use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

my @m = (0, 0, 0, 1);
my $t = 0;

open(FILE, '<', "10.txt") or die $!;
map { $m[$_ - $t]++; $t = $_ } sort { $a <=> $b } <FILE>;
close(FILE);
say $m[1]*$m[3];
