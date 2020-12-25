use strict;
use warnings;
use v5.12.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use Math::Trig;

my ($x, $y, $wx, $wy, $wd) = (0, 0, 10, 1, 0);
open(FILE, '<', "12.txt") or die $!;
map {
	m/(\w)(\d+)/;
	$1 eq "F" && ($x += $2 * $wx, $y += $2 * $wy);
	$1 eq "N" && ($wy += $2);
	$1 eq "S" && ($wy -= $2);
	$1 eq "W" && ($wx -= $2);
	$1 eq "E" && ($wx += $2);

	my $wd = 0;
	$1 eq "L" && ($wd = $2/90);
	$1 eq "R" && ($wd = 4-$2/90);
	if($wd) {
		my $tx = $wx;
		if($wd % 4 == 1) { $wx = -$wy; $wy =  $tx }
		if($wd % 4 == 2) { $wx = -$wx; $wy = -$wy }
		if($wd % 4 == 3) { $wx =  $wy; $wy = -$tx }
	}
} <FILE>;
close(FILE);

say abs($x)+abs($y);
