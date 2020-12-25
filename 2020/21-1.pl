use strict;
use warnings;
use v5.21.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use List::Compare;

open(FILE, '<', "21.txt") or die $!;
my @file = map $_, <FILE>;
close(FILE);

my (%m, %in);
sub prt { dump %m; }
map {
	my @l = map { [split /[, )\n]+/] } split ".contains ", $_;
	map { $in{$_} = 1 } @{$l[0]};
	map { push @{$m{$_}}, $l[0] } @{$l[1]}; # [@{$l[1]}] } @{$l[0]};
} @file;

dump %m;
my %n = %m;
foreach(keys %m) {
	@{$m{$_}} > 1 && (@{$m{$_}} = [List::Compare->new(@{$m{$_}})->get_intersection]);
}

my @t = map @$_, map @$_, values %m;
$file[0] = join "", @file;
dump grep { not $_ ~~ @t } keys %in;
dump sum map { scalar(split $_, $file[0]) - 1 } grep { not $_ ~~ @t } keys %in
#>190 <2380
