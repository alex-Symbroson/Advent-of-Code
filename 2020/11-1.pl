use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use Storable qw(dclone);
use Digest::MD5 qw(md5_hex);

open(FILE, '<', "11.txt") or die $!;
my @m = map { [0, (map { index ".L#", $_ } split "", tr/\n//dr), 0] } <FILE>;
close(FILE);

sub getf { return $m[$_[1]][$_[0]] == 2; }

push @m, [map {0} @{$m[0]}];
unshift @m, [map {0} @{$m[0]}];

while(1) {
	my @t = @{dclone \@m};
	for (my $y = 1; $y+1 < @m; $y++) {
		for (my $x = 1; $x+1 < @{$m[$y]}; $x++) {
			$m[$y][$x] % 3 == 0 && next;
			my $n = getf($x-1, $y-1) + getf($x, $y-1) + getf($x+1, $y-1) +
					getf($x-1, $y-0) +       0        + getf($x+1, $y-0) +
					getf($x-1, $y+1) + getf($x, $y+1) + getf($x+1, $y+1);
			$m[$y][$x] == 1 && $n == 0 && ($t[$y][$x] = 2);
			$m[$y][$x] == 2 && $n >= 4 && ($t[$y][$x] = 1);
		}
	}
	if((dump @m) eq (dump @t)) { last; }
	@m = @t;
}

$_ = (dump \@m) =~ tr/2//;
say $_;
