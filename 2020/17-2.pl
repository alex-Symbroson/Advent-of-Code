use strict;
use warnings;
use v5.16.1;
use List::Compare;
use List::Util qw(any);
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use experimental 'smartmatch';

my ($x1, $y1, $z1, $w1, $x2, $y2, $z2, $w2, $w, $h, $d, $t, $X, $Y, $Z, $W, @m) =
	(-4,  -4,   0,   0,   4,   4,   0,   0, 24, 24, 24, 24);

for $W(0..$t) { for $Z(0..$d) {
for $Y(0..$h) { for $X(0..$w) {
	$m[$W][$Z][$Y][$X] = [0, 0];
}}}}

($X, $Y, $Z, $W) = ($x1, $y1, $z1, $w1);
open(FILE, '<', "17.txt") or die $!;
map {
	map { $_ eq "#" && ($m[0][0][$Y][$X][0] = 1); $X++ } split m/|\n/;
	$Y++; $X = $x1;
} <FILE>;
close(FILE);

for my $i(1..6) {
	my $c = 0;
	for my $i(0..1) {
	for $W($w1-1..$w2+1) { for $Z($z1-1..$z2+1) {
	for $Y($y1-1..$y2+1) { for $X($x1-1..$x2+1)
	{
		my $cur = \@{$m[$W][$Z][$Y][$X]};
		unless($i)
		{
			my $n = 0;
			for my $dw(-1..1) { for my $dz(-1..1) {
			for my $dy(-1..1) { for my $dx(-1..1) {
				($dx||$dy||$dz||$dw) && $m[$W+$dw][$Z+$dz][$Y+$dy][$X+$dx][0] && $n++;
			}}}}
			$cur->[1] = $n;
		}
		else {
			if($cur->[0] ? $cur->[1] == 2 || $cur->[1] == 3 : $cur->[1] == 3) {
				$cur->[0] = 1;
				$c++;
				$x1 = min($X,$x1); $x2 = max($X,$x2);
				$y1 = min($Y,$y1); $y2 = max($Y,$y2);
				$z1 = min($Z,$z1); $z2 = max($Z,$z2);
				$w1 = min($W,$w1); $w2 = max($W,$w2);
			} else {
				$cur->[0] = 0;
			}
		}
	}}}}}
	say "-----$c-------";
}

#>3.6
