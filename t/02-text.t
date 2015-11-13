use strict;
use warnings;
use Test::More tests => 12;
use Win32::Clipboard;

my $clip = Win32::Clipboard();

my $text = "This is some text...";

$clip->Set($text);

is ($clip->Get(), $text, "Fetch value from clipboard.");
is ($clip->GetText(), $text, "Fetch text from clipboard.");
is ($clip->GetBitmap(), '', "Clipboard does not contain a bitmap.");
is ($clip->GetFiles(), '', "Clipboard does not contain a list of files.");

ok ($clip->IsText, "Value is text.");
ok (!$clip->IsBitmap, "Value is not a bitmap.");
ok (!$clip->IsFiles, "Value is not a list of files.");

ok ($clip->IsFormatAvailable(CF_TEXT), "Clipboard contains text.");
ok (!$clip->IsFormatAvailable(CF_DIB), "Clipboard does not contain a bitmap info.");
ok (!$clip->IsFormatAvailable(CF_HDROP), "Clipboard does not contain a list of files.");

my $cf_text_num = CF_TEXT;
is_deeply ([grep { /^$cf_text_num$/ } $clip->EnumFormats()], [CF_TEXT], "EnumFormats returns CF_TEXT.");

$clip->Empty();

is ($clip->Get(), '', "Clipboard is empty.");
