#!perl -w
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

# TODO: test for GetBitmap/SetBitmap

use strict;
use vars qw( $loaded $clip $actual );

######################### We start with some black magic to print on failure.

BEGIN { $| = 1; print "1..12\n"; }
END {print "not ok 1\n" unless $loaded;}
use Win32::Clipboard;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

$clip = Win32::Clipboard();
print "not" unless ref($clip) =~ /Win32::Clipboard/;
print "ok 2\n";

$clip->Set("Win32::Clipboard test");
$actual = $clip->Get();
print "not " unless $actual eq "Win32::Clipboard test";
print "ok 3\n";

print "not " unless $clip->IsText();
print "ok 4\n";

$clip->Empty();
print "not " unless $clip->Get() eq "";
print "ok 5\n";

undef $clip;

tie $clip, 'Win32::Clipboard';

print "not" unless tied($clip) and ref(tied($clip)) =~ /Win32::Clipboard/;
print "ok 6\n";

$clip = "Win32::Clipboard test";
$actual = $clip;
print "not " unless $actual eq "Win32::Clipboard test";
print "ok 7\n";

tied($clip)->Empty();
print "not " unless $clip eq "";
print "ok 8\n";

$clip = "Win32::Clipboard test";
print "not " unless tied($clip)->IsText();
print "ok 9\n";

# unicode clipboard checks
use utf8;

Win32::Clipboard::USet("qwerty");
my $s = Win32::Clipboard::UGet();
print "not " unless $s eq "qwerty";
print "ok 10\n";

print +(utf8::is_utf8($s)? '' : "not ") . "ok 11\n";

Win32::Clipboard::USet("проба пера");
print "not " unless Win32::Clipboard::UGet() eq "проба пера";
print "ok 12\n";

