use strict;
use warnings;
use v5.22.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum reduce];

open(FILE, '<', "22.txt") or die $!;
my (@l, $w) = map [split "\n"], split "\n\n", join "", <FILE>;
close(FILE);

shift @{$l[0]}; shift @{$l[1]};

while(1) {
	my ($a, $b) = (shift @{$l[0]}, shift @{$l[1]});
	push @{$l[$w = $a < $b]}, $w ? ($b, $a) : ($a, $b);
	unless (@{$l[!$w]}) { last; }
}

@{$l[$w]} = reverse @{$l[$w]};
say sum map { $l[$w][$_]*++$_ } (0..$#{$l[$w]})
