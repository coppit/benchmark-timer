# ========================================================================
# t/03_statistical.t - ensure that Benchmark::Timer object can be created,
# used for statistical measurement
# David Coppit <david@coppit.org>
#
# Test statistical usage of the Benchmark::Timer library.
#
# Because timings will differ from system to system, we can't actually
# test the functionality of the module. So we just test that all the
# method calls run without triggering exceptions.
#
# This script is intended to be run as a target of Test::Harness.
#
# Last modified September 2, 2004
# ========================================================================

use strict;
use Test;

BEGIN { plan tests => 4 }

# ------------------------------------------------------------------------

unless (eval 'require Statistics::PointEstimation')
{
  for (1 .. 5)
  {
    skip("Skip optional module Statistics::PointEstimation is not installed",1);
  }

  exit;
}

# ------------------------------------------------------------------------

# Statistical tests of the Benchmark::Timer library.

use Benchmark::Timer;
use Time::HiRes qw( usleep );

my $t = Benchmark::Timer->new(minimum => 3, confidence => 97.5, error => .5);

# 1
ok(1);

my $time = time;

while( $t->need_more_samples('tag') )
{
  $t->start('tag');

  sleep 1;

  $t->stop('tag');

  print $t->get_report;
}

# 2
ok(1);

my $result = $t->result('tag');

# 3
ok(defined $result ? 1 : 0);

my @data = $t->data('tag');

use Data::Dumper;
print "Data:\n", Dumper \@data;

# 4
ok(@data >= 3 ? 1 : 0);

# ========================================================================
__END__
