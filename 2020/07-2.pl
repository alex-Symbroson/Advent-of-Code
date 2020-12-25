use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);

sub trim { $_ = shift; s/^\s+|\s+$//g; return $_; }

open(FILE, '<', "07.txt") or die $!;
while(<FILE>) {
	/(.+?) bags contain((,? (\d+|no) (.+?) bags?)+)\./;
	for (split / bags?,? ?/, trim $2) {
		push @{$map{$1}}, split " ", $_, 2;
	}
}
close(FILE);


my @search = (["shiny gold", 1]);
my $n = 0;

while(-1 < $#search) {
	my @newsearch = ();
	for (@search) {
		my @arr = @{$map{$_->[0]}};
		for (my $i = 0; $i < @arr; $i += 2) {
			if ($arr[$i] ne "no") {
				push @newsearch, [$arr[$i+1], $arr[$i]*$_->[1]];
				$n += $newsearch[-1]->[1];
			}
		}
	}
	@search = @newsearch;
}
say $n;
