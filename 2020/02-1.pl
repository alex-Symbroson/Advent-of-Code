use strict;
use warnings;
use v5.10.1;

my $res = 0;

open(FILE, '<', "02.txt") or die $!;
while(<FILE>) {
	my @d = split /[: -]+/, $_;
	my $n = split($d[2], $d[3]) - 1;
	$d[0] <= $n and $n <= $d[1] and $res++;
}
close(FILE);

say $res;
