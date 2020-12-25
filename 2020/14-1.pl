use strict;
use warnings;
use v5.14.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use bigint qw/oct/;

open(FILE, '<', "14.txt") or die $!;
my @l = map { [m/(mem|mask)(?:\[(\d+)\])? = ([\dX]+)/] } <FILE>;
close(FILE);

my %mem = ();
my ($mask0, $mask1);

sub setmask {
	$_ = $_[0];
	$mask0 = oct("0b".tr/X/1/r);
	$mask1 = oct("0b".tr/X/0/r);
}

for my $cmd (@l) {
	$cmd->[0] eq "mem" && ($mem{$cmd->[1]} = ($cmd->[2] & $mask0) | $mask1);
	$cmd->[0] eq "mask" && setmask($cmd->[2]);
	#dump [@{$cmd}], [$mask0, $mask1], [%mem];
}

say sum(values %mem);
