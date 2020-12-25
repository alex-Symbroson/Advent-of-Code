use strict;
use warnings;
use v5.20.1;
use Data::Dump qw(dump);
use List::Util qw[min max sum reduce];
use List::Compare;
use Array::Transpose;

# gave up on this

open(FILE, '<', "20.txt") or die $!;
my ($n, $w, @m, @z) = (0);
my @l = map {
	[ map { m/\.|#/ ? (oct("0b".tr/.#/01/r), oct("0b".reverse tr/.#/01/r)) : $_ }
	m/(.+?)\n(.+?)\n.*\n([^\n]+)$/s, (join "", m/\n(.)/g), (join "", m/([^:\n])$/gm), 0, $n++, 0 ]
} (@z = split "\n\n", join "", <FILE>);
close(FILE);
$w = @l**0.5;

sub its {
	my $t = shift;
	grep { $t != $_ && List::Compare->new([@{$t}[1..8]], [@{$_}[1..8]])->get_intersection } @_
}

sub geta { for(1..$_[0]) { $_[0][$_] ~~ $_[1] && return $_ } }

sub prm {
	#say "::prm - (",$_[0],",",$_[1], ") - ", join ",",@{$_[2]}; #dump @_;
	$_[2] && ($m[$_[0]][$_[1]] = $_[2]);
	$_[2] && (@l = grep { $_ != $_[2] } @l);
}

sub prt {
	say " (".join "\n  ", map { join ",", map { $_->[10] =~ m/(\d+)/ } @{$_} } @m;
}

sub fY { [reverse @{$_[0]}] }
sub fX { [map [reverse @{$_}], @{$_[0]}] }
sub tp { [transpose $_[0]] } # trp
sub rt { r2(tp @_) } # rev trp
sub rr { fX(tp @_) } # rot c-wise
sub rl { fY(tp @_) } # rot c-c-wise
sub r2 { fX(fY @_) } # rot 180
sub np { @_ } # rot 180

my @os = @{$l[1]};
my @t1 = (\&np, \&rr, \&rt, \&tp, \&rl, \&fX, \&r2, \&np, \&fY);
my @t2 = (\&np, \&fY, \&r2, \&np, \&fX, \&rl, \&rt, \&tp, \&rr);
my @t3 = (\&np, \&tp, \&rl, \&rr, \&rt, \&np, \&fY, \&fX, \&r2);
my @t4 = (\&np, \&np, \&fX, \&fY, \&r2, \&tp, \&rr, \&rl, \&rt);

prm 0, 0, $l[1]; #104

# build matrix
for my $y (0..$w-2) {
for my $x (0..$w-1) {
	#$m[$y][$x] && next;
	#say "yx: $y, $x";
	my @s = its $m[$y][$x], @l;
	# say "::s"; dump @s;
	unless ($y || $x) { }
	elsif (@s > 1) { # say "::u";
		my @t = its $m[$y+1][$x-1], @s; # prt;
		@s = ($s[$t[0] == $s[0]], $t[0]);
	} else { @s = (0, $s[0]) }
	#$m[$y][$x][11] = geta $m[$y][$x], $s[1];
	#$s[1][11] = geta $s[1], $m[$y][$x];
	say "$y+1,$x: ", geta $s[1], $m[$y][$x];
	# $x || ($m[$y][$x][11] = geta $m[$y][$x], $s[1]);
	#$s[1][12] = geta $s[0], $m[$y][$x];
	prm $y, $x+1, $s[0];
	prm $y+1, $x, $s[1];
	#say geta @o;
}
}
prt;

# dump @m;

# build final matrix with rotated tiles
@m = map { [map {
	$t4[$_->[11]]->([(
		map [(split "")[0..9]], split "\n", $z[$_->[10]]
	)[1..10]])
} @{$_}] } @m;

@m = join "\n", map {
	my @ls = @{$_->[0]};
	#dump @ls;
	for my $lc (@{$_}[1..$#{$_}]) {
		for(0..9) { # @{$lc->[0]}) {
			# $ls[$_] = ($ls[$_], $lc->[$_])
			push @{$ls[$_]}, " ", @{$lc->[$_]}
		}
	}
	#dump @ls;
	say "\n", join "\n", map {join "", @{$_}} @ls;
	0;
	#say join "\n", map {join ",", @{$_}} @ls;
	#join "\n", map {join "", @{$_}} @ls
} @m;
#say @m;
