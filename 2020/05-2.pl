use strict;
use warnings;
use v5.10.1;
use experimental 'switch';

my @seats = 0..1024;

open(FILE, '<', "05.txt") or die $!;
while(<FILE>) {
	#my ($x, $y, $w, $h) = (0, 0, 128, 8);
	#foreach (split "") {
	#	when ("F") { $w /= 2; }
	#	when ("B") { $x += $w /= 2; }
	#	when ("L") { $h /= 2; }
	#	when ("R") { $y += $h /= 2; }
	#}
	$seats[oct("0b".tr/FBLR\n/0101\0/r)] = '';
}
close(FILE);

say ((join ",", @seats) =~ /,,(\d+),,/);
