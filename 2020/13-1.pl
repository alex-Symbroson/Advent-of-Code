use strict;
use warnings;
use v5.13.1;

open(FILE, '<', "13.txt") or die $!;
my $t = <FILE>;
my @res = sort { $a->[0] <=> $b->[0] } map { [$_ - ($t % $_), int($_)] } map { m/\d+/g } <FILE>;
say $res[0][1] * $res[0][0];
close(FILE);
