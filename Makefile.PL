#!/usr/bin/perl

use strict;
use inc::Module::Install;

Check_Custom_Installation();

print "\n", '-'x78, "\n\n";

name            ('Benchmark-Timer');
author          ('David Coppit <david@coppit.org>');
abstract_from   ('lib/Benchmark/Timer.pm');
version_from    ('lib/Benchmark/Timer.pm');
license         ('gpl');

requires        (
                  'Time::HiRes' => 0,
                );

# Optional features and their modules
features        (
                  'Statistical sampling support' => [
                    -default    => 1,
                    recommends( 'Statistics::PointEstimation' => 0 ),
                  ],
                );

skip            ('delta.pl');

clean_files     ('t/temp');

include         ('ExtUtils/AutoInstall.pm');

auto_install    ( );
WriteAll();

print "\n", '-'x78, "\n\n";

exit;
