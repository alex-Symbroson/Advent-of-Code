
use strict;
use warnings;
use v5.16.1;
use Data::Dump qw(dump);
use List::Util qw(sum);

open(FILE, '<', "16.txt") or die $!;
my @l = split "\n\n", join "", <FILE>;
my @rs = map { m/(\d+)-(\d+) or (\d+)-(\d+)/g; ($1..$2, $3..$4) } split "\n", $l[0];
close(FILE);

my @tickets = split m/,|\n/, $l[2];
shift @tickets;
say sum grep { !($_ ~~ @rs) } @tickets; #@{$l[2]}[1..$#{$l[2]}];
