# ========================================================================
# t/02_skip.t - test skip functionality in Benchmark::Timer
# Andrew Ho (andrew@zeuscat.com)
#
# Test the skip functionality in Benchmark::Timer, where you can provide
# a parameter named skip to the constructor to skip that many trials
# for all timings. This is useful for throwing away the first n of m
# trials where m is large.
#
# This script is intended to be run as a target of Test::Harness.
#
# Last modified April 20, 2001
# ========================================================================

use strict;
use Test;
use Benchmark::Timer;

BEGIN { plan tests => 5 }


# ------------------------------------------------------------------------
# Test that a Benchmark::Timer created with a zero skip functions the
# same as a Benchmark::Timer created without a skip at all.

my $t1 = Benchmark::Timer->new;
my $t2 = Benchmark::Timer->new(skip => 0);

$t1->reset;
$t2->reset;

for(1 .. 10) {
    $t1->start('tag1');
    $t2->start('tag2');
    $t1->stop;
    $t2->stop;
}

my @r1 = $t1->data('tag1');
my @r2 = $t2->data('tag2');

ok(scalar @r1 == scalar @r2 ? 1 : 0);


# ------------------------------------------------------------------------
# Skip 1 trial, get n - 1 trials total.

my $n = 10;
my $t = Benchmark::Timer->new(skip => 1);
for(1 .. $n) {
    $t->start('tag');
    $t->stop;
}
my @r = $t->data('tag');

ok(scalar @r == $n - 1 ? 1 : 0);


# ------------------------------------------------------------------------
# Skip n - 1 trials, get 1 trial total.

$n = 10;
undef $t; $t = Benchmark::Timer->new(skip => $n - 1);
for(1 .. $n) {
    $t->start('tag');
    $t->stop;
}
@r = $t->data('tag');

ok(scalar @r == 1 ? 1 : 0);


# ------------------------------------------------------------------------
# Skip n trials, get no trials at all.

$n = 10;
undef $t; $t = Benchmark::Timer->new(skip => $n);
for(1 .. $n) {
    $t->start('tag');
    $t->stop;
}
@r = $t->data('tag');

ok(scalar @r == 0 ? 1 : 0);


# ------------------------------------------------------------------------
# Skip n + 1 trials, also get no trials at all.

$n = 10;
undef $t; $t = Benchmark::Timer->new(skip => $n + 1);
for(1 .. $n) {
    $t->start('tag');
    $t->stop;
}
@r = $t->data('tag');

ok(scalar @r == 0 ? 1 : 0);


# ========================================================================
__END__
