package Getopt::Casual;

=pod

=head1 NAME

Getopts::Casual - A simpler, kinder replacement for Getopt::*.

=head1 SYNOPSIS

use Getopt::Casual;

print $_, ' = ', $ARGV{ $_ }, "\n" for keys %ARGV if $ARGV{ '--demo' };

(see F<example.pl>)

=head1 DESCRIPTION

Getopt::Casual affords a person writing a command line utility the
ability to not have to predeclare command line switches.  Instead, the
programmer can check the keys of %ARGV to see if an argument exists.
The arguments can have a value or simply be set to 1, depending on the
following basic rules:

1)  Arguments can be single characters or and combination of characters.

2)  Arguments that begin with a '-' followed by a string, which can
include spaces if the string is enclosed by quotes, will have the
value of that string.

3)  Arguments that begin with a '-' followed by another string that
begins with a '-', including quoted strings that contain spaces, will
have a value of 1.

4)  Arguments that do not begin with a '-' will have a value of one.
When preceded by an odd number of arguments that begin with a dash,
this string is a value of the previous command line argument.

5)  All arguments of the script can be found as either a key or a
value of %ARGV in the callers namespace.

=head1 EXAMPLES

See the included program called F<example.pl>.

./example.pl a a a
a = 1

./example.pl a b
a = 1
b = 1

./example.pl a -b
a = 1
-b = 1

./example.pl -a b
-a = b

./example.pl -a -b
-a = 1
-b = 1

./example.pl --debug 2
--debug = 2

./example.pl -debug 2
-debug = 2

=head1 BUGS

If you find one, please tell me or supply a patch.

=cut

use strict;
no strict 'refs';

use vars qw/ $VERSION @ISA /;
use Exporter;

$VERSION = "0.06";

@ISA = qw/ Exporter /;

my $caller  = (caller)[ 0 ];
my $verbose = $Getopt::Casual::verbose;

print 'Accessing @ARGV in package ', $caller, "\n" if $verbose;
@ARGV = @{ join '::', $caller, 'ARGV' };

for (my $i = 0; $i < @ARGV; $i++, my $skip = 0) { 

  print 'Current argument: ', $_ = $ARGV[ $i ], ' value: ' if $verbose;
  local $_ = ${ join '::', $caller, 'ARGV'}{ $ARGV[ $skip ? $i++ : $i ] } =
    $ARGV[ $i ] =~ /^-/ && $i + 1 < @ARGV ? $ARGV[ $i + 1 ] =~ /^-/ ? 1 : 
     $ARGV[ $i + 1 ] ? do{ $skip++; $ARGV[ $i + 1 ]} : 1 : 1;
  print $_, "\n" if $verbose;

}

sub import {

  my $self = shift;
  for (my $i = 0; $i < @_; $i++, my $skip = 0) {

    ${ join '::', $caller, 'ARGV'}{ $_[ $skip ? $i++ : $i ] } = 
      $_[ $i ] =~ /^-/ && $i + 1 < @_ ? $_[ $i + 1 ] =~ /^-/ ? 1 : 
        $_[ $i + 1 ] ? do{ $skip++; $_[ $i + 1 ] } : 1 : 1;

  }

};

=pod

=head1 SEE ALSO

L<Getopt::Std>, L<Getopt::Long>

=head1 NOTES

There has been some doubt as to whether or not this was useful enough
to have to remember to tote it with you to every system on which you
had command line perl scripts.  The obvious advantage of the core
modules is that they are wherever perl is installed.  If portablity 
is really a key issue, use the core modules.

=head2 AUTHOR

Daniel M. Lipton <photo@tiac.net>

=cut

1;
