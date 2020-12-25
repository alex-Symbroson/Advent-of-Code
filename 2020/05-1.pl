use strict;
use warnings;
use v5.10.1;

my $hid = -1;

open(FILE, '<', "05.txt") or die $!;
while(<FILE>) {
	#my ($x, $y, $w, $h) = (0, 0, 128, 8);
	#foreach (split "") {
		#print $x."..".($x+$w-1).", ".$y."..".($y+$h-1)."\n".$_." ";
	#	when ("F") { $w /= 2; }
	#	when ("B") { $x += $w /= 2; }
	#	when ("L") { $h /= 2; }
	#	when ("R") { $y += $h /= 2; }
	#}
	#print $x*8+$y, "\n";
	$_ = oct("0b".tr/FBLR\n/0101\0/r);
	$hid = $_ if $_ > $hid;
}
close(FILE);

print $hid;
