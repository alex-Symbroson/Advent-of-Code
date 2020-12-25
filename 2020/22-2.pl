use strict;
use warnings;
use v5.22.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum reduce];

open(FILE, '<', "22.txt") or die $!;
my (@tl, $w) = map [split "\n"], split "\n\n", join "", <FILE>;
shift @{$tl[0]}; shift @{$tl[1]};
close(FILE);
my $x;

sub RC2 { max(@{$_[0]}) < max(@{$_[1]}) && RC(@_) }

sub RC {
	my (@l, %m) = ($_[0], $_[1]);
	while(1) {
		$x++;
		#$m{join "", @{$l[0]},",",@{$l[1]}}++ && return 0;
		$m{join ",", @{$l[0]}}++ && return 0; # aoc is lying 2 me
		my ($a, $b) = (shift @{$l[0]}, shift @{$l[1]});
		my $r = $a <= @{$l[0]} && $b <= @{$l[1]} ? RC2([@{$l[0]}[0..$a-1]], [@{$l[1]}[0..$b-1]]) : $a < $b;
		push @{$l[$w = $r]}, $r ? ($b, $a) : ($a, $b);
		@{$l[!$r]} || return $r
	}
}

$w = RC $tl[0], $tl[1];
say $x;
@{$tl[$w]} = reverse @{$tl[$w]};
say sum map { $tl[$w][$_] * ++$_ } (0..$#{$tl[$w]})
