# version using globs 10x slower
use strict;
use warnings;
use v5.16.1;
use List::Compare;
use List::Util qw(any);
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use experimental 'smartmatch';

my ($x1, $y1, $z1, $w1, $x2, $y2, $z2, $w2, $w, $h, $d, $t, @m) =
	(-4,  -4,   0,   0,   4,   4,   0,   0, 24, 24, 24, 24);

$" = ',';
for my $C (map { [split /:/] } glob "{@{[0..$t-1]}}:{@{[0..$d-1]}}:{@{[0..$h-1]}}:{@{[0..$w-1]}}") {
	$m[$C->[0]][$C->[1]][$C->[2]][$C->[3]] = [0, 0];
}

open(FILE, '<', "17.txt") or die $!; # weird hacky input parsing
my $Y = $y1;
map {
	my $X = $x1;
	map { $_ eq "#" && ($m[$w1][$z1][$Y][$X][0] = 1); $X++ } split m/|\n/;
	$Y++;
} <FILE>;
close(FILE);

#my ($C->[4], $C->[3], $C->[2], $C->[1]);
for my $i(1..6) {
	my $c = 0;
	for my $C (map { [split /:/] } glob "{0,1}:{@{[$w1-1..$w2+1]}}:{@{[$z1-1..$z2+1]}}:{@{[$y1-1..$y2+1]}}:{@{[$x1-1..$x2+1]}}") {

		my $cur = \@{$m[$C->[1]][$C->[2]][$C->[3]][$C->[4]]};
		unless($C->[0])
		{
			my $n = 0;
			for my $D (map { [split /:/] } glob "{-1,0,1}:{-1,0,1}:{-1,0,1}:{-1,0,1}") {
				($D->[0]||$D->[1]||$D->[2]||$D->[3]) &&
					$m[$C->[1]+$D->[0]][$C->[2]+$D->[1]][$C->[3]+$D->[2]][$C->[4]+$D->[3]][0] && $n++;
			}
			$cur->[1] = $n;
		}
		else {
			if($cur->[0] ? $cur->[1] == 2 || $cur->[1] == 3 : $cur->[1] == 3) {
				$cur->[0] = 1;
				$c++;
				$x1 = min($C->[4],$x1);
				$y1 = min($C->[3],$y1);
				$z1 = min($C->[2],$z1);
				$w1 = min($C->[1],$w1);
				$x2 = max($C->[4],$x2);
				$y2 = max($C->[3],$y2);
				$z2 = max($C->[2],$z2);
				$w2 = max($C->[1],$w2);
			} else {
				$cur->[0] = 0;
			}
		}
	}
	say "-----$c-------";
}

#>3.6
