use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Win32::Clipboard' ) || print "Bail out!\n";
}

diag( "Testing Win32::Clipboard $Win32::Clipboard::VERSION, Perl $], $^X" );
