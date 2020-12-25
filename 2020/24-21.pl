use strict;
use warnings;
use v5.24.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use Time::HiRes qw(usleep);


open(FILE,'<',"24.txt") or die$!;
my@l=map{[m/(se|sw|w|e|nw|ne)/g]}<FILE>;
my%d=("sw",[1,-1],"w",[0,-1],"nw",[-1,0],"se",[1,0],"e",[0,1],"ne",[-1,1]);
close(FILE);

for(@l){
	my($x,$y);
	for(@{$_}){$y+=$d{$_}[0];$x+=$d{$_}[1]}
	$m{"$y,$x"}=1-($m{"$y,$x"}||0);
}
for my$i(1..100){
	for my$k(keys%m){my($y,$x)=split",",$k;$m{$k}&1&&map$m{"@{[$y+$_->[0]]},@{[$x+$_->[1]]}"}+=2,values%d}
	for(keys%m){(($m{$_}>>1)==2||(($m{$_}&1)&&($m{$_}>>1)==1))&&($m{$_}|=1)||($m{$_}=$m{$_}&~1);$m{$_}&=1}
}
say sum map{$_&1}values%m
