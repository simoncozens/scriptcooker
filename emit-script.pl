use Unicode::UCD qw(charinfo charscript);
use JSON::XS;
use File::Slurp;
my $database = decode_json(read_file("scripts.json"));

for my $n (keys %$database) {
  my @l = @{charscript($n)};
  my @cps;
  for (@l) { push @cps, $_ for $_->[0]..$_->[1] };
  $database->{$n}{count} = $#cps;
  $database->{$n}{codepoints} = \@cps;
}

print "ScriptCooker.scripts = " . encode_json($database);
