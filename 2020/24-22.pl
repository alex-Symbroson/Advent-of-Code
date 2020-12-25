use strict;
use warnings;
use v5.24.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum];
use Time::HiRes qw(usleep);

open(FILE,'<',"24.txt")or die$!;
my@l=map{[m/[sn]?[we]/g]}<FILE>;$;=',';
my(%d,%m)=("sw",[1,-1],"w",[0,-1],"nw",[-1,0],"se",[1,0],"e",[0,1],"ne",[-1,1]);
close(FILE);

for(@l){
	my($x,$y);
	for(@{$_}){$y+=$d{$_}[0];$x+=$d{$_}[1]}
	$m{$y,$x}=1-($m{$y,$x}||0);
}
for my$i(1..100){
	for(keys%m){my($y,$x)=split",";$m{$_}&1&&map$m{$y+@$_[0],$x+@$_[1]}+=2,values%d}
	for(keys%m){$m{$_}=$m{$_}>2&&$m{$_}<6}
}
say sum map{$_&1}values%m

# $k=[split",",$k];$m{"@$k"}&1&&map$m{@$k[0]+$_->[0],@$k[1]+$_->[1]}+=2,values%d}
