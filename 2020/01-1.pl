use strict;
use warnings;

my @arr = [];

open(FILE, '<', "01.txt") or die $!;
out:
while(<FILE>) {
	my $t = int($_);
	foreach my $n (@arr) {
		if($n + $t == 2020) {
			say $n*$t;
			last out;
		}
	}
	push @arr, $t;
}

close(FILE);
