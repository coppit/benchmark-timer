# ========================================================================
# t/99_errors.t - test fatal and warn error cases
# Andrew Ho (andrew@zeuscat.com)
#
# In this test we exercise fatal conditions and check that they really
# do die with an error status.
#
# This script is intended to be run as a target of Test::Harness.
#
# Last modified April 20, 2001
# ========================================================================

use strict;
use Test;
use Benchmark::Timer;

BEGIN { plan tests => 6 }


# ------------------------------------------------------------------------
# Check fatal condition where you call stop() but start() has NEVER run

eval {
    my $t = Benchmark::Timer->new;
    $t->stop;
};
ok($@ && $@ =~ /must call/ ? 1 : 0);


# ------------------------------------------------------------------------
# Check fatal out of sync condition

eval {
    my $t = Benchmark::Timer->new;
    $t->start('tag');
    $t->stop;
    $t->stop;
};
ok($@ && $@ =~ /out of sync/ ? 1 : 0);


# ------------------------------------------------------------------------
# Check fatal bad skip argument handling

eval { my $t = Benchmark::Timer->new( skip => undef ) };
ok($@ && $@ =~ /argument skip/ ? 1 : 0);

eval { my $t = Benchmark::Timer->new( skip => 'foo' ) };
ok($@ && $@ =~ /argument skip/ ? 1 : 0);

eval { my $t = Benchmark::Timer->new( skip => -1 ) };
ok($@ && $@ =~ /argument skip/ ? 1 : 0);


# ------------------------------------------------------------------------
# Check warning on unrecognized arguments

use vars qw($last_warning);
undef $last_warning;
{
    local $SIG{__WARN__} = sub { $last_warning = shift };
    my $weird_arg = '__this_is_not_a_valid_argument__';
    my $t = Benchmark::Timer->new( $weird_arg => undef );
    ok($last_warning =~ /skipping unknown/ ? 1 : 0);
}


# ========================================================================
__END__
