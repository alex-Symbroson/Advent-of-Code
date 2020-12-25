use strict;
use warnings;
use v5.10.1;

open(FILE, '<', "03.txt") or die $!;
my @f = map { [ map { $_ eq "." ? 0 : 1 } split /|\n/, $_ ] } <FILE>;
close(FILE);

my $h = @f;
my $w = @{$f[0]};

sub slope {
	my ($x, $y, $t) = (0, 0, 0);
	while($y < $h) {
		$t += $f[$y][$x % $w];
		$x += $_[0]; $y += $_[1];
	}
	return $t;
}

say slope(1,1)*slope(3,1)*slope(5,1)*slope(7,1)*slope(1,2);
