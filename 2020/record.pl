use Memory::Usage;
my $mu = Memory::Usage->new();
$mu->record('start');
$mu->record('end');
$mu->dump();

