use strict;
use warnings;
use v5.10.1;

my @f;
my $cnt = 0;
my @has = split ",", "byr,iyr,eyr,hgt,hcl,ecl,pid"; #,cid

open(FILE, '<', "04.txt") or die $!;
while(<FILE>) {
	if($_ eq "\n") {
		$cnt++;
		foreach my $c (@has) {
			unless (grep { $_ eq $c } @f) { $cnt--; last; }
		}

		@f = (); next;
	}
	foreach (split " ", $_) {
		push @f, (split ":", $_)[0];
	}
}
close(FILE);

say $cnt;
