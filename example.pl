#!/usr/local/bin/perl

use Getopt::Casual;

map { print $_, " = ", $ARGV{ $_ }, "\n"; } keys %ARGV;

