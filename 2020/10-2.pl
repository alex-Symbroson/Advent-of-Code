use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

my ($t, $n, $c) = (0, 1, 0);
my @m = (1,1,1,2,4,7);

open(FILE, '<', "10.txt") or die $!;
for(0, sort { $a <=> $b } <FILE>) {
	if($_ - $t == 3) {
		$n *= $m[$c], $c = 0;
	}
	$t = $_, $c++;
}
close(FILE);

say $n*$m[$c];
