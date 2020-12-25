use strict;
use warnings;
use v5.20.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum reduce];
use List::Compare;
use Array::Transpose;

open(FILE, '<', "20.txt") or die $!;
my @l = map {
	[ map { m/\.|#/ ? (oct("0b".tr/.#/01/r), oct("0b".reverse tr/.#/01/r)) : $_ }
	m/(.+?)\n(.+?)\n.*\n([^\n]+)$/s, (join "", m/\n(.)/g), (join "", m/([^:\n])$/gm), 0 ]
} split "\n\n", join "", <FILE>;
close(FILE);

map { my $t = $_; map { my $u = $_; $t != $u && ($t->[9] += grep { $_ ~~ @{$u} } @{$t}[1..8]); } @l } @l;
say reduce { $a * $b } map { say $_->[0]; $_->[0] =~ m/(\d+)/ } grep { $_->[9] == 4 } @l

# for my $t (@l) {
# 	for my $u (@l) {
# 		$t != $u && ($t->[9] += grep { $_ ~~ @{$u} } @{$t}[1..8]);
# 	}
# }
