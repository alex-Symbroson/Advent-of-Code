use strict;
use warnings;
use v5.10.1;

my ($ans, $n) = ("-", 0);

open(FILE, '<', "06.txt") or die $!;
while(<FILE>) {
	if($_ eq "\n") {
		$n += length $ans;
		$ans = "-";
	}
	else {
		$ans eq "-" ? $ans = tr/\n//dr : $ans =~ s/[^$_]//g;
	}
}
close(FILE);

say $n-1;
