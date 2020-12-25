use strict;
use warnings;
use v5.13.1;
use Data::Dump qw(dump);

open(FILE, '<', "13.txt") or die $!; <FILE>;
my $d = 0;
my @l = sort { $b->[0] <=> $a->[0]} grep { $_->[0] }
		map {[int, $d++]} split ",", <FILE>;
close(FILE);

#dump @l;

my @n = @{shift @l};
$d = $n[0];
#@n[0] *= 1e11;

while(1) {
	my $found = 1;

	for(@l) {
		my @e = @{$_};
		my $t = int(1+$n[0]/$e[0])*$e[0]-$e[1];
		if($n[0]-$n[1]-$t) { $found = 0; last; }
	}
	#$n[0] >= 3417 && last;
	$found && last;
	if(@n[0]%1e8<$d) {say $n[0]+$n[1];}
	$n[0] += $d;
}

say $n[0]+$n[1]; #, ", ", join ", ", map {int(1+$n[0]/$_->[0])*$_->[0]+$_[1]} @l;
