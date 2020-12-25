use strict;
use warnings;
use v5.23.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use List::MoreUtils qw(first_index);

my @l = map $_-1, split "", "871369452";
my $x = @l;

sub rol ( \@ ) { my $lr = shift; push(@$lr, shift @$lr); }
sub ror ( \@ ) { my $lr = shift; unshift(@$lr, pop @$lr); }
sub pr { say join "", map $_ + 1, @l }

for(1..100) {
	my $c = $l[0]-1;
	rol @l;
	my @t = (shift @l, shift @l, shift @l);
	ror @l;
	#until($c % $x ~~ @l) { $c += $x-1 }
	while($c % $x ~~ @t) { $c += $x-1 }
	my $p = first_index { $c % $x == $_ } @l;
	for(0..$p) { rol @l }
	for(1..3) { unshift @l, pop @t }
	for(1..$p) { ror @l }
}

pr;
for(1..(first_index { !$_ } @l)) { rol @l; }
shift @l;
pr;
