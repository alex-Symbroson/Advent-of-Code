use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);

my ($accum, $ip);

my %op = (
	"nop", sub { },
	"acc", sub { $accum += $_[0]; },
	"jmp", sub { $ip += $_[0]-1; }
);

open(FILE, '<', "08.txt") or die $!;
my @prog = map { [(split " ", s/\n$//gr, 2), 0] } <FILE>;
close(FILE);

my $i = -1;
outer:
for (@prog) {
	for(@prog) { $_->[-1] = 0; }

	if($prog[++$i]->[0] eq "acc") { next; }
	$prog[$i]->[0] =~ tr/nojm/jmno/; #swap nop<>jmp

	($accum, $ip) = (0, 0);
	while (1) {
		my $cmd = $prog[$ip];
		$prog[$ip++]->[-1]++ && last;
		$op{$cmd->[0]}->($cmd->[1]);  #(split " ", $cmd->[1]);
		unless (defined $prog[$ip]) {
			say $accum; last outer;
		}
	}

	$prog[$i]->[0] =~ tr/nojm/jmno/; #swap nop<>jmp
}
