use strict;
use warnings;

open(FILE, '<', "03.txt") or die $!;
my @f = map { [ map { $_ eq "." ? 0 : 1 } split /|\n/, $_ ] } <FILE>;
close(FILE);


my $h = @f;
my $w = @{$f[0]};

my ($x, $y, $t) = (0, 0, 0);
while($y < $h) {
	$t += $f[$y][$x % $w];
	$x += 3; $y += 1;
}

say $t;
