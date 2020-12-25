use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);

my $accum = 0;
my $ip = 0;

my %op = (
	"nop", sub { },
	"acc", sub { $accum += $_[0]; },
	"jmp", sub { $ip += $_[0]-1; }
);

open(FILE, '<', "08.txt") or die $!;
my @prog = map { s/\n$//g; [(split " ", $_, 2), 0] } <FILE>;
close(FILE);

while (1) {
	$_ = $prog[$ip];
	$prog[$ip++]->[-1]++ && last;
	$op{$_->[0]}->(split " ", $_->[1]);
}

say $accum;
