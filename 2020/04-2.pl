use strict;
use warnings;
use v5.10.1;

my @f;
my ($cnt, $imp) = (0, 0);
my %tests = (
	"byr", sub { $imp--; return $_[0] >= 1920 && $_[0] <= 2002; },
	"iyr", sub { $imp--; return $_[0] >= 2010 && $_[0] <= 2020; },
	"eyr", sub { $imp--; return $_[0] >= 2020 && $_[0] <= 2030; },
	"hgt", sub { $imp--; ($_[0] =~ /^(\d+)(cm|in)$/) &&
		return $2 eq "cm" ?
			$1 >= 150 && $1 <= 193 :
			$1 >= 59 && $1 <= 76;
	},
	"hcl", sub { $imp--; return $_[0] =~ /^\#[0-9a-f]{6}$/; },
	"ecl", sub { $imp--; return $_[0] =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/; },
	"pid", sub { $imp--; return $_[0] =~ /^\d{9}$/; },
	"cid", sub { return 1; });


open(FILE, '<', "04.txt") or die $!;

while(<FILE>) {
	if($_ eq "\n") {
		$cnt++; $imp = 7;
		foreach (@f) {
			unless ($tests{$_->[0]}->($_->[1])) { $imp++; last; }
		}
		if($imp != 0) { $cnt--; }

		@f = (); next;
	}

	foreach (split " ", $_) {
		push @f, [split ":", $_];
	}
}
close(FILE);

say $cnt;
