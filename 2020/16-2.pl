use strict;
use warnings;
use v5.16.1;
use List::Compare;
use List::Util qw(any);
use experimental 'smartmatch';

open(FILE, '<', "16.txt") or die $!; # weird hacky input parsing
my (@l, @m, $t) = map { [map { [split ","] } split "\n"] } split "\n\n", join "", <FILE>;
my @rs = map { $_->[0] =~ m/(\d+)-(\d+) or (\d+)-(\d+)/g; [$1..$2, $3..$4] } @{$l[0]};
$l[2] = [grep { not any { not $_ ~~ @rs } @{$_} } @{$l[2]}[1..$#{$l[2]}]]; # prefilter
close(FILE);

for (my $ir = 0; $ir <= $#rs; $ir++) { # 3D loop as [rule][ticket][index]
	my ($it, @t) = 0;
	for my $ticket (@{$l[2]}) {
		for (my $in = 0; $in <= $#{$ticket}; $in++) {
			$ticket->[$in] ~~ @{$rs[$ir]} && push @{$t[$it]}, $in;
		}
		$it++;
	}
	@t = grep { $#{$_} < 19 } @t; # save intersection of possible indices for a rule
	$#t > -1 && push @m, $#t ? [$ir+$#rs+1, List::Compare->new(@t)->get_intersection] : @t;
}

($t, @m) = (1, sort { $#$b <=> $#$a } @m); # sort by list length desc
for (my $i = 1; $i < $#m; $i++) { # complement two arrs to get single diff element
	my @n = sort { $a <=> $b } List::Compare->new(reverse @m[$i..$i+1])->get_complement;
	$l[0]->[$n[1]-$#rs-1] ~~ m/^departure/ && ($t *= $l[1]->[1]->[$n[0]]); # multiply results
}

say $t;
