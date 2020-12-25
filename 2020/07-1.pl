use strict;
use warnings;
use v5.10.1;
use Data::Dump qw(dump);

my (%map) = ();
sub trim { $_ = ; return s/^\s+|\s+$//gr; }

open(FILE, '<', "07.txt") or die $!;
while(<FILE>) {
	/(.+?) bags contain((,? (\d+|no) (.+?) bags?)+)\./;
	my $cur = $1;
	for (split / bags?,? ?/, trim $2) {
		push @{$map{$cur}}, split " ", $_, 2;
	}
}
close(FILE);


my @search = ("shiny gold");
my %bags = ();

while(-1 < $#search) {
	my @newsearch = ();
	for my $want (@search) {
		for my $bag (keys %map) {
			if($want ~~ @{$map{$bag}}) {
				push @newsearch, $bag;
				$bags{$bag} = 1;
			}
		}
	}
	@search = @newsearch
}

my $n = keys %bags;
dump $n;
