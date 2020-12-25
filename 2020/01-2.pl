use strict;
use strict;
use warnings;

my @arr = [];

open(FILE, '<', "01.txt") or die $!;
out:
while(<FILE>) {
	my $t = int($_);
	foreach my $n (@arr) {
		foreach my $m (@arr) {
			$m == $n and next;
			if($n + $m + $t == 2020) {
				say $n*$m*$t;
				last out;
			}
		}
	}
	push @arr, $t;
}

close(FILE);
