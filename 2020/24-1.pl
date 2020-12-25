use strict;
use warnings;
use v5.24.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

open(FILE, '<', "24.txt") or die $!;
my @l = map { [m/(se|sw|w|e|nw|ne)/g] } <FILE>;
close(FILE);
my %d = (
	"sw", [-1,-1], "w", [0,-1], "nw", [1,0],
	"se", [-1, 0], "e", [0, 1], "ne", [1,1]);
my %m;

for(@l) {
	my ($x, $y) = (0, 0);
	for(@{$_}){
		#print "$_ ";
		$y += $d{$_}[0]; $x += $d{$_}[1];
	}
	$m{"$x,$y"} = 1-($m{"$x,$y"}||0);
	#say "($x, $y)";
}

#dump %m;
say sum values %m;
