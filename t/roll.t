#!/usr/bin/perl -w

# near-trivial tests for bin/roll, the D&D dice roller
# run from the repo root (CI does this too): prove t/

use strict;
use warnings;
use Test::More;

# roll 2d6: header, two in-range rolls, total <= max
{
	my $out = `perl bin/roll 2d6`;
	is( $? >> 8, 0, '2d6 exits 0' );
	like( $out, qr/^2d6:\n/, 'prints dice header' );
	my @rolls = $out =~ /^\troll \d+: (\d+)$/gm;
	is( scalar @rolls, 2, 'two dice rolled' );
	my @bad = grep { $_ < 1 || $_ > 6 } @rolls;
	ok( !@bad, 'each roll lands in 1..6' );
	like( $out, qr/^\ttotal: (\d+)\/12$/m, 'prints total over max' );
	my ($total) = $out =~ /^\ttotal: (\d+)\/12$/m;
	ok( $total >= 2 && $total <= 12, 'total lands in 2..12' );
}

# roll d20 (count defaults to 1): one roll, no total line
{
	my $out = `perl bin/roll d20`;
	is( $? >> 8, 0, 'd20 exits 0' );
	like( $out, qr/^d20:\n\troll 1: (\d+)\n\z/, 'single roll, no total' );
	my ($rolled) = $out =~ /(\d+)\n\z/;
	ok( $rolled >= 1 && $rolled <= 20, 'd20 roll lands in 1..20' );
}

# multiple dice arguments roll separately
{
	my $out = `perl bin/roll 3d6 3d6`;
	is( $? >> 8, 0, 'two args exit 0' );
	my @headers = $out =~ /^(\S+):$/gm;
	is_deeply( \@headers, [ '3d6', '3d6' ], 'each argument rolled separately' );
}

# invalid notation: non-zero exit and a complaint
{
	my $out = `perl bin/roll xyz 2>&1`;
	isnt( $? >> 8, 0, 'invalid notation exits non-zero' );
	like( $out, qr/xyz not in 2d6 format/, 'invalid notation explained' );
}

# no arguments: nothing to roll, exits clean
{
	my $out = `perl bin/roll`;
	is( $? >> 8, 0, 'no args exits 0' );
	is( $out, '', 'no args, no output' );
}

done_testing();
