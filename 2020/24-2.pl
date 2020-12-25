use strict;
use warnings;
use v5.24.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use Time::HiRes qw(usleep);

my ($x1, $y1, $x2, $y2, %m) = (-55, -55, 55, 55);

open(FILE, '<', "24.txt") or die $!;
my @l = map { [m/(se|sw|w|e|nw|ne)/g] } <FILE>;
close(FILE);
my %d = ("sw", [1,-1], "w", [0,-1], "nw", [-1,0],
		 "se", [1, 0], "e", [0, 1], "ne", [-1,1] );

for(@l) {
	my ($x, $y) = (0, 0);
	for(@{$_}) { $y += $d{$_}[0]; $x += $d{$_}[1] }
	$m{"$y,$x"} = 1-($m{"$y,$x"}||0);
}

sub prt {
	say "";
	for my $y (-56..56) {
		for (0..$y+56) { print " " }
		for my $x (-56..56) {
			my $cur = $m {"$y,$x"} || 0;
			print $cur&1 ? "# " : ". "; #, $cur >> 1, " "
		}
		$y || print "  ", sum map {$_&1} values %m;
		print "\n";
	}
	say "@_";
	usleep(600000);
}

for my $i (1..100) {
	for (keys %m) {
		my ($y, $x) = (split ",", $_);
		if ($m{$_} & 1) {
			for (values %d) {
				my $ct = "@{[$y+$_->[0]]},@{[$x+$_->[1]]}";
				$m{$ct} += 2;
			}
		}
	}
	for (keys %m) {
		my ($cp, $cur) = ($_, $m{$_});
		if (($cur >> 1) == 2 || (($cur & 1) && ($cur >> 1) == 1))
			{ $m{$cp} |= 1 } else { $m{$cp} = $m{$cp} & ~1 }
		$m{$_} &= 1
	}
	#prt "end";
}

say sum map {$_&1} values %m;
