use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

my @l = ();

open(FILE, '<', "09.txt") or die $!;
@l = map { int($_) } <FILE>;
close(FILE);

my $num = 138879426;
outer:
for my $n (2..@l-1) {
	for my $i (0..@l-$n-1) {
		if(sum(@l[$i..$i+$n]) == $num) {
			say min(@l[$i..$i+$n]) + max(@l[$i..$i+$n]);
			last outer;
		}
	}
}
