#!/usr/bin/perl

use strict;

use inc::Module::Install;
use File::Slurp;

all_from('lib/Benchmark/Timer.pm');

githubmeta;

include(
  'File::Slurp' => 0,
);

requires(
  'Time::HiRes' => 0,
);

test_requires(
  'Test::More' => 0,
);

check_optional('Statistics::PointEstimation' => 0,
  "Install Statistics::PointEstimation for statistical sampling support\n");

# Module::Install doesn't figure out that Module::Install::CheckOptional needs
# this. Include it manually.
include(
  'Module::AutoInstall' => 0,
);

no_index('delta.pl');

license 'gpl2';
auto_license(holder => 'David Coppit');

WriteAll();

if (auto_tester) {
  my $makefile = read_file('Makefile');
  $makefile =~ s/TEST_VERBOSE\s*=\s*0/TEST_VERBOSE=1/ or die "Couldn't enable verbose mode in Makefile";
  write_file('Makefile', $makefile);
}
