print '1..2', "\n";

package a;

delete $INC{ 'Getopt/Casual.pm' };
@a::ARGV = qw/ a b c d /;
require 'Getopt/Casual.pm';

if ($a::ARGV{ 'a' } == 1 && $a::ARGV{ 'b' } == 1 &&
    $a::ARGV{ 'c' } == 1 && $a::ARGV{ 'd' } == 1) {

  print 'ok 1', "\n";

} else {

  print 'not ok 1', "\n";

}

package b;

delete $INC{ 'Getopt/Casual.pm' };
@b::ARGV = qw/ -a -b -c -d /;
require 'Getopt/Casual.pm';

if ($b::ARGV{ '-a' } == 1 && $b::ARGV{ '-b' } == 1 &&
    $b::ARGV{ '-c' } == 1 && $b::ARGV{ '-d' } == 1) {

  print 'ok 2', "\n";

} else {

  print 'not ok 2', "\n";

}
