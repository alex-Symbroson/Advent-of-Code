use strict;
use warnings;
use v5.10.1;

my $res = 0;

open(FILE, '<', "02.txt") or die $!;
while(<FILE>)
{
	my @d = split /[: -]+/, $_;
	my @l = split "", $d[3];

	($l[$d[0]-1] eq $d[2]  xor
	 $l[$d[1]-1] eq $d[2]) and $res++;
}
close(FILE);

say $res;
