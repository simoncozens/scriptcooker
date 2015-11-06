use Unicode::UCD qw(charinfo charscript);
use JSON::XS;
use File::Slurp;
use LWP::Simple;
my $database = decode_json(read_file("scripts.json"));

for my $n (keys %$database) {
  my @l = @{charscript($n)};
  my @cps;
  for (@l) { push @cps, $_ for $_->[0]..$_->[1] };
  $database->{$n}{codepoints} = [ map { [$_, charinfo($_)->{name}]} @cps ];
  my $code;
  if ($code = $database->{$n}{udhr} and $code =~ /^\w+$/) {
    warn "Getting http://unicode.org/udhr/d/udhr_".$code.".txt\n";
    my $udhr = get("http://unicode.org/udhr/d/udhr_".$code.".txt");
    if (!$udhr) { warn " Failed!\n"}
    $udhr =~ s/.*?^---\s+//ms;
    $udhr =~ /(.*\n.*\n.*\n.*)/;
    if ($1) { $udhr = $1;
      $udhr =~ s/\s+/ /msg;
      $database->{$n}{udhr} = $udhr;
    }
  }
}

print "ScriptCooker.scripts = " . encode_json($database);
