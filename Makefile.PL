#!/usr/bin/perl
# use perl                                  -*- mode: Perl; -*-

use strict;
use inc::Module::Install;
use lib 'lib';
use File::Spec;

require 5.004;

Check_Custom_Installation();

print "\n","-"x78,"\n\n";

name            ('Benchmark-Timer');
author          ('David Coppit <david@coppit.org>');
abstract_from   ('lib/Benchmark/Timer.pm');
version_from    ('lib/Benchmark/Timer.pm');
license         ('gpl');
clean_files     ('t/temp');

requires        ('Time::HiRes');
features        (
  'Statistical sampling support' => [
    recommends( 'Statistics::PointEstimation' => 0 ),
  ],
);

skip            ('delta.pl');

include('ExtUtils/AutoInstall.pm');
auto_install( -default => 0 );

WriteAll();

print "\n","-"x78,"\n";

exit;
