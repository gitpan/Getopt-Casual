#!/usr/bin/perl -w

use strict;
use Getopt::Casual;

map { print $_, " = ", $ARGV{ $_ }, "\n"; } sort keys %ARGV;

