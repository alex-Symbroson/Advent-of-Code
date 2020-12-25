use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum any];
use Storable qw(dclone);
use Digest::MD5 qw(md5_hex);

open(FILE, '<', "11.txt") or die $!;
my @m = map { [3, (map { index ".L#", $_ } split "", tr/\n//dr), 3] } <FILE>;
close(FILE);

push @m, [map {3} @{$m[0]}];
unshift @m, [map {3} @{$m[0]}];

while(1) {
	my @t = @{dclone \@m};

	for (my $y = 1; $y+1 < @m; $y++) {
		for (my $x = 1; $x+1 < @{$m[$y]}; $x++) {
			$m[$y][$x] % 3 == 0 && next;
			my @s = (0, 0, 0, 0, 0, 0, 0, 0);
			for(my $m = 1; any { $_ == 0 } @s; ++$m) {
				!$s[0] && ($s[0] = $m[$y+$m][$x]);
				!$s[1] && ($s[1] = $m[$y-$m][$x]);
				!$s[2] && ($s[2] = $m[$y][$x+$m]);
				!$s[3] && ($s[3] = $m[$y][$x-$m]);
				!$s[4] && ($s[4] = $m[$y+$m][$x+$m]);
				!$s[5] && ($s[5] = $m[$y-$m][$x+$m]);
				!$s[6] && ($s[6] = $m[$y+$m][$x-$m]);
				!$s[7] && ($s[7] = $m[$y-$m][$x-$m]);
			}
			my $n = sum(map { $_ == 2 } @s);
			$n == 0 && $m[$y][$x] == 1 && ($t[$y][$x] = 2);
			$n >= 5 && $m[$y][$x] == 2 && ($t[$y][$x] = 1);
		}
	}
	if((dump @m) eq (dump @t)) { last; }
	@m = @t;
}

$_ = (dump \@m) =~ tr/2//;
say $_;
