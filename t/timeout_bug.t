use strict;
use warnings;
use Test::More tests => 1;
use Win32::Clipboard;

# This is a test case for bug:
# https://rt.cpan.org/Public/Bug/Display.html?id=43841

# Currently, WaitForChange needs to be called at least 2 times in order to work properly.

TODO: {
  local $TODO = "WaitForChange always returns 1 and doesn't wait when called for the first time.";

  my $clip = Win32::Clipboard->new();

  my $start = time;
  my $what = $clip->WaitForChange(5000);

  cmp_ok abs( 5 - time + $start ), '<=', 2;
}
