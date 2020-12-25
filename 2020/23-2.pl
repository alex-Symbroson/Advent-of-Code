use strict;
use warnings;
use v5.23.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use List::MoreUtils qw(first_index last_index);
use Time::HiRes;

my @l = ((map $_-1, split "", "389125467"), (10-1..1e6-1));

sub rol ( \@ ) { my $lr = shift; push(@$lr, shift @$lr); }
sub ror ( \@ ) { my $lr = shift; unshift(@$lr, pop @$lr); }
sub pr { say join "", map $_ + 1, @l }
my $x = @l;
my @ps = ($x-4, $x-26);
my ($tRot, $tSrc);

for(1..1e7) {
	my $c = $l[0]-1;
	rol @l;
	my @t = (shift @l, shift @l, shift @l);
	ror @l;
	while($c % $x ~~ @t) { $c += $x-1 }

	# my $p = first_index { $c % $x == $_ } @l[@ps];
	# unless($p == -1) { $p = $ps[$p]; }
	# else {
	# 	$p = last_index { $c % $x == $_ } @l;
	# 	push @ps, $p;
	# }

	my $p;
	#my $t1 = Time::HiRes::time();
	for(0..$x) {
		$c % $x == $l[$_] && ($p = $_, last);
		$c % $x == $l[$x-$_-4] && ($p = $x-$_-1, last);
	}
	#my $t2 = Time::HiRes::time();

	unless($_ % 1e5) {
		@ps = sort { $a <=> $b } @ps;
		say $_, " ", min($x-$p,$p); #, " $tRot, $tSrc";
		#dump @ps;
	}

	#my $t3 = Time::HiRes::time();
	#@l = (@l[0..$p], @t, @l[$p..$x-1]);
	if($p < $x/2) {
		for(0..$p) { rol @l }
		for(1..3) { unshift @l, pop @t }
		for(1..$p) { ror @l }
	} else {
		for($p-1..$x) { ror @l }
		for(1..3) { unshift @l, pop @t }
		for($p..$x) { ror @l }
	}
	#my $t4 = Time::HiRes::time();
	#$tRot += $t4-$t3;
	#$tSrc += $t2-$t1;
}

for(1..(first_index { !$_ } @l)) { rol @l; }
dump shift @l, shift @l, shift @l;
