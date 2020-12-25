use strict;
use warnings;
use v5.12.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

my ($x, $y, $d) = (0, 0, 0);
open(FILE, '<', "12.txt") or die $!;
map {
	my @c = m/(\w)(\d+)/;
	$c[0] eq "F" && ($c[0] = qw(E S W N)[$d % 4]);
	$c[0] eq "N" && ($y -= $2);
	$c[0] eq "S" && ($y += $2);
	$c[0] eq "W" && ($x -= $2);
	$c[0] eq "E" && ($x += $2);
	$c[0] eq "L" && ($d += 4-$2/90);
	$c[0] eq "R" && ($d += $2/90);
	#$td != $d && say "$x,$y,$d ", $d-$td, "  ", join ",", @c;
} <FILE>;
close(FILE);

say abs($x)+abs($y);
