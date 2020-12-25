use strict;
use warnings;
use v5.25.1;
use Data::Dump qw(dump);
use List::Util qw[reduce];

sub pk2ls {
	my ($ls, $r, $sn) = (0, 1, 7);
	while($r != $_[0] && ++$ls) { $r = $r * 7 % 20201227 } $ls
}
sub trf { reduce { $a * $_[0] % 20201227 } 1..$_[1]+1 }

my ($cpk, $dpk) = (15733400, 6408062); # (5764801, 17807724)
say trf($cpk, pk2ls $dpk);
say trf($dpk, pk2ls $cpk);
