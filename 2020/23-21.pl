use strict;
use warnings;
use v5.23.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use List::MoreUtils qw(first_index last_index);
use Time::HiRes;

# gave up on dis

my ($n, $ci) = (0, 0);
my %l = map {($_, ++$n)} ((map $_, split "", "871369452")); #, (10-1..1e6-1));
# my $x = keys %l;

dump %l;
sub pr {
	for(keys %l) { print } say "";
}
pr;
for(1..10) { }

# for(1..10) {
# 	my $c = $l[0]-1;
# 	rol @l;
# 	my @t = (shift @l, shift @l, shift @l);
# 	#say @t;
# 	ror @l;
# 	while($c % $x ~~ @t) { $c += $x-1 }
#
# 	# my $p = first_index { $c % $x == $_ } @l[@ps];
# 	# unless($p == -1) { $p = $ps[$p]; }
# 	# else {
# 	# 	$p = last_index { $c % $x == $_ } @l;
# 	# 	push @ps, $p;
# 	# }
#
# 	my $p;
# 	for(0..$x) {
# 		$c % $x == $l[$_] && ($p = $_, last);
# 		$c % $x == $l[$x-$_-4] && ($p = $x-$_-4, last);
# 	}
#
# 	unless($_ % 1e5) { say $_, " ", min($x-$p,$p); }
#
# 	#@l = (@l[0..$p], @t, @l[$p..$x-1]);
# 	if($p < $x/2) {
# 		for(0..$p) { rol @l }
# 		for(1..3) { unshift @l, pop @t }
# 		for(1..$p) { ror @l }
# 	} else {
# 		for($p-1..$x) { ror @l }
# 		for(1..3) { unshift @l, pop @t }
# 		for($p..$x) { ror @l }
# 	}
# }
#
# for(1..(first_index { !$_ } @l)) { rol @l }
# dump shift @l, shift @l, shift @l;
