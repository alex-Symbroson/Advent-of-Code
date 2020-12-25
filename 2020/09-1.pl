use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];

my @l = ();

open(FILE, '<', "09.txt") or die $!;
@l = map { int($_) } <FILE>;
close(FILE);

for my $i (25..@l-1) {
	my $found = 0;
	search:
	for $a (max(0, $i-25)..$i-2) {
		for $b($a+1..$i-1) {
			#say "$i.$a.$b";
			if($l[$i] == $l[$a]+$l[$b]) {
				$found = 1;
				#say $l[$i]." = ".$l[$a]." + ".$l[$b];
				last search;
			}
		}
	}
	unless($found) {say "fail ".$l[$i];last;}
}
