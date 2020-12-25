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

my $t;
sub setmem {
	my @l = split "", sprintf "%.36b", $_[0];
	my $val = $_[1];
	my $mask = $mask0 ^ $mask1;
	for(0 .. 35) {
		($mask >> (35 - $_)) & 1 && (@l[$_] = "{0,1}");
	}
	my $ts = time;
	for(split " ", `bash -c 'echo @{[join "", @l]}'`) {
		$mem{oct("0b".$_)} = $val;
	}
	$t += time - $ts;
}

for my $cmd (@l) {
	$cmd->[0] eq "mem" && setmem($cmd->[1] | $mask1, $cmd->[2]);
	$cmd->[0] eq "mask" && setmask($cmd->[2]);
	#dump [@{$cmd}], [$mask0, $mask1], [%mem];
}

say sum(values %mem);
#say "W: ".`echo {01}01{01}01{01}}1`;
say $t;
