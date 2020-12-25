use strict;
use warnings;
use v5.18.1;
use List::Util qw[sum];

open(FILE, '<', "18.txt") or die $!;
say sum map {
	j1:
	s/\((\d+)\)/$1/g && goto j1;
	s/(\d+) \+ (\d+)/$1+$2/ge && goto j1;
	s/(?!\+ )(\b\d+) \* (\d+\b)(?! \+)/$1*$2/e && goto j1;
	$_;
} <FILE>;
close(FILE);
