use strict;
use warnings;
use v5.15.1;

my ($i, $v, %m) = (0, 0, ());
open(FILE, '<', "15.txt") or die $!;
my @l = map {$m{(int)} = $i++; $v = int} split ",", <FILE>;
close(FILE);

for ($i = @l; $i < 3e7; $i++) {
	my $t = defined($m{$v}) ? $i - $m{$v} - 1 : 0;
	$m{$v} = $i - 1;
	$v = $t;
	$i % 3e6 || $mu->record((100*$i/3e7)."%");
}

say $v;
