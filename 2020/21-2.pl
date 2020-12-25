use strict;
use warnings;
use v5.23.1;
use List::Util qw(first sum);

my (%sus, %ic, %where);
open(FILE, '<', "21.txt") or die $!;
while (<FILE> =~ /^(.*) \(contains (.*)\)$/) {
    my @ig = split " ", $1;
    my @ag = split ", ", $2;
    for(@ig) { $ic{$_}++ }
    for my $a (@ag) {
        my @m = @ig;
        if(defined $sus{$a}) { @m = grep { $sus{$a}->{$_} } @ig };
        $sus{$a} = { map {$_ => 1} @m }
    }
}
close(FILE);

while(1) {
    my $ag = first { keys %{$sus{$_}} == 1 } keys %sus;
    unless($ag) {last}
    my ($ig) = %{$sus{$ag}};
    $where{$ag} = $ig;
    for(values %sus) { delete $_->{$ig} }
    delete $ic{$ig};
}

say sum values %ic;
say join ',', map { $where{$_} } sort keys %where;
