# ========================================================================
# t/01_basic.t - ensure that Benchmark::Timer object can be created, used
# Andrew Ho (andrew@zeuscat.com)
#
# Test basic usage of the Benchmark::Timer library.
#
# Because timings will differ from system to system, we can't actually
# test the functionality of the module. So we just test that all the
# method calls run without triggering exceptions.
#
# This script is intended to be run as a target of Test::Harness.
#
# Last modified April 20, 2001
# ========================================================================

use strict;
use Test;

BEGIN { plan tests => 12 }


# ------------------------------------------------------------------------
# Basic tests of the Benchmark::Timer library.

use Benchmark::Timer;
ok(1);

my $t = Benchmark::Timer->new;
ok($t ? 1 : 0);

$t->reset;
ok(1);

$t->start('tag');
$t->stop;
ok(1);

print $t->get_report;
ok(1);

my $result = $t->result('tag');
ok(defined $result ? 1 : 0);

my @results = $t->results;
ok(@results == 2 ? 1 : 0);

my $results = $t->results;
ok(ref $results eq 'ARRAY' ? 1 : 0);

my @data = $t->data('tag');
ok(@data == 1 ? 1 : 0);

my $data = $t->data('tag');
ok(ref $data eq 'ARRAY' ? 1 : 0);

@data = $t->data;
ok(@data == 2 ? 1 : 0);

$data = $t->data;
ok(ref $data eq 'ARRAY' ? 1 : 0);


# ========================================================================
__END__
