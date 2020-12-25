use strict;
use warnings;
use v5.16.1;
use List::Compare;
use List::Util qw(any);
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use experimental 'smartmatch';

my ($x1, $y1, $z1, $x2, $y2, $z2, $w, $h, $d, $x, $y, $z, @m) =
	(-4,  -4,   0,   4,   4,   0, 32, 32, 32);

# my @m = [[[0 for $x(0..$w)] for $y(0..$h)] for $z(0..$d)];
for $z(0..$d) {
	for $y(0..$h) {
		for $x(0..$w) {
			$m[$z]->[$y]->[$x] = [0, 0];
		}
	}
}

($x, $y, $z) = ($x1, $y1, $z1);
open(FILE, '<', "17.txt") or die $!; # weird hacky input parsing
map {
	map {
		$_ eq "#" && ($m[0]->[$y]->[$x]->[0] = 1);
		$x++
	} split m/|\n/;
	$y++; $x = $x1;
} <FILE>;
close(FILE);

for my $i(1..6) {
	my $c = 0;
	for my $m(0..1) {
		for $z($z1-1..$z2+1) {
			for $y($y1-1..$y2+1) {
				for $x($x1-1..$x2+1)
				{
					my $cur = \@{$m[$z]->[$y]->[$x]};
					unless($m)
					{
						my $n = 0;
						for my $dz(-1..1) {
							for my $dy(-1..1) {
								for my $dx(-1..1) {
									($dx||$dy||$dz) && $m[$z+$dz]->[$y+$dy]->[$x+$dx]->[0] && $n++;
								}
							}
						}
						$cur->[1] = $n;
					}
					else {
						if($cur->[0] ? $cur->[1] == 2 || $cur->[1] == 3 : $cur->[1]==3) {
							$cur->[0] = 1;
							$c++;
							$x1 = min($x,$x1);
							$y1 = min($y,$y1);
							$z1 = min($z,$z1);
							$x2 = max($x,$x2);
							$y2 = max($y,$y2);
							$z2 = max($z,$z2);
						} else {
							$cur->[0] = 0;
						}
						#print $cur->[0].$cur->[1]." ";
					}
				}
				#$m && print "\n";
			}
			#$m && print "\n";
		}
	}
	say "-----$c-------";
}
