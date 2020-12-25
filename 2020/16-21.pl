use strict;
use warnings;
use v5.16.1;
use Data::Dump qw(dump);
use List::Util qw(any);
use List::Compare;

open(FILE, '<', "16.txt") or die $!;
my @l = split "\n\n", join "", <FILE>;
$l[0] = [split "\n", $l[0]];
$l[1] = [split m/,|\n/, $l[1]];
my @rs = map { m/(\d+)-(\d+) or (\d+)-(\d+)/g; [$1..$2, $3..$4] } @{$l[0]};
close(FILE);

my @tickets = map { [split ","] } split m/\n/, $l[2];
shift @tickets;
@tickets = grep { not any { not $_ ~~ @rs } @{$_} } @tickets;
$l[2]=[@tickets];

my ($ir, @m) = 0;

for my $r (@rs) { # 3D loop as [rule][ticket][index]
	my ($it, @t) = 0;
	for my $ticket (@tickets) {
		my $in = 0;
		for my $n (@{$ticket}) {
			$n ~~ @{$r} && push @{$t[$it]}, $in;
			$in++;
		}
		$it++;
	}
	@t = grep { $#{$_} < 19 } @t; # save intersection of possible indices for a rule
	$#t > -1 && push @m, $#t ? [100+$ir, List::Compare->new(@t)->get_intersection] : @t;
	$ir++;
}

($ir, @m) = (1, sort { $#$b <=> $#$a } @m); # sort by list length desc
for (my $i = 1; $i < $#m; $i++) { # complement two arrs to get single diff element
	my @n = sort { $a <=> $b } List::Compare->new(reverse @m[$i..$i+1])->get_complement;
	$l[0]->[$n[1]-100] ~~ m/^departure/ && ($ir *= $l[1]->[1+$n[0]]); # multiply results
}

say $ir;
