use strict;
use warnings;
use v5.15.1;
use Data::Dump qw(dump);
use List::MoreUtils qw(last_index);

open(FILE, '<', "15.txt") or die $!;
my @l = map {int} split ",", <FILE>;
close(FILE);


my ($i, $p);
for ($i = @l; $i < 2020; $i++) {
	$p = last_index { $_ == $l[$i-1] } @l[0..$i-2];
	push @l, $p > -1 ? @l-$p-1 : 0;
	#say $i,". ",$l[$i],". ", $l[$i-1],". ", $p,".  ", join ",",@l[0..$i-2];
}
say $l[$i-1];
