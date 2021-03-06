#!perl -T

use strict;
use warnings;
use Test::More tests => 18;
use FindBin '$Bin';
($Bin) = $Bin =~ /(.+)/;

our $Perl;
our $Dir;

require "$Bin/testlib.pl";
prepare_for_testing();

test_perlmv([1, 2, 3], {code=>'$_*4'}, [12, 4, 8], 'normal');
test_perlmv([1, 2, 3], {code=>'$_*4', dry_run=>1, verbose=>1}, [1, 2, 3], 'dry_run');
test_perlmv([1, 2, 3], {code=>'$_*4', compile=>1}, [1, 2, 3], 'compile');
test_perlmv([1, 2, 3], {code=>'"a"'}, ["a", "a.1", "a.2"], 'automatic .\d+ suffix on conflict');
test_perlmv([1, 2, 3], {code=>'"b"', overwrite=>1}, ["b"], 'overwrite');
test_perlmv(["a"], {code=>'"b/c/d"'}, ["a"], 'parents off');
test_perlmv(["a"], {code=>'"b/c/d"', parents=>1}, ["b"], 'parents on');
test_perlmv([1, 2, 3], {code=>'$_++'}, ["2.1", "3.1", "4"], 'reverse off');
test_perlmv([1, 2, 3], {code=>'$_++', reverse_order=>1}, ["2", "3", "4"], 'reverse on');

end_testing();
