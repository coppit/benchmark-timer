# ========================================================================
# t/00_loadlib.t - simple test that the Benchmark::Timer library loads
# Andrew Ho (andrew@zeuscat.com)
#
# Test loading the Benchmark::Timer library.
# This script is intended to be run as a target of Test::Harness.
#
# Last modified March 26, 2001
# ========================================================================

use strict;
use Test;

BEGIN { plan tests => 1 }


# ------------------------------------------------------------------------
# Test loading the Benchmark::Timer library

use Benchmark::Timer;
ok(1);


# ========================================================================
__END__
