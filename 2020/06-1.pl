use strict;
use warnings;
use v5.10.1;

my ($ans, $n) = ("", 0);

open(FILE, '<', "06.txt") or die $!;
while(<FILE>) {
	if($_ eq "\n") {
		$n += length $ans;
		$ans = "";
	}
	else { $ans .= s/[\n$ans]//gr; }

	#for (split "", $_) {
	#	$_ eq "\n" && next;
	#	!($ans =~ /$_/) && ($ans.=$_);
	#}
}
close(FILE);

say $n;
