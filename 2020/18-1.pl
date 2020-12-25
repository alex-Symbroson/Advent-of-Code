use strict;
use warnings;
use v5.18.1;
use List::Util qw[sum];

open(FILE, '<', "18.txt") or die $!;
say sum map {
	j1:
	s/\((\d+)\)/$1/g && goto j1;
	s/(\d+) ([+*]) (\d+)/$2 eq "+"?$1+$3:$1*$3/e && goto j1;
	$_;
} <FILE>;
close(FILE);
