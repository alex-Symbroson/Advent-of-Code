use strict;
use warnings;
use v5.13.1;
use Data::Dump qw(dump);

open(FILE, '<', "13.txt") or die $!; <FILE>;
my $d = 0;
my @l = grep { $_->[0] } map {[int, (int) - $d++]} split ",", <FILE>;
close(FILE);
for(@l) { while($_->[1] < 0) { $_->[1] += $_->[0] } }

use ntheory qw(chinese lcm);
dump chinese([1789,0],[37,36],[47,45],[1889,1886]);

#say $n[0]+$n[1]; #, ", ", join ", ", map {int(1+$n[0]/$_->[0])*$_->[0]+$_[1]} @l;

# <1131189818632523
# < 638639863941323
