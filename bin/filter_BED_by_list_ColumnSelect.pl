#! /usr/bin/perl

die "usage:\t\tperl filter_BED_by_list_ColumnSelect.pl\tBED_File\tList_File_Values\tColumn-Index (0-based)\tkeep/remove\tOutput_BED\nExample:\tperl filter_BED_by_list_ColumnSelect.pl input.bed ids.tab 4 keep output.bed\n" unless $#ARGV == 4;
my($input, $cdt, $COLUMN, $STATUS, $output) = @ARGV;

use List::Util 'first';

if($STATUS ne "keep" && $STATUS ne "remove") {
	print "Invalid Status entered: $STATUS\n";
	print "Only keep or remove allowed\n";
	exit;
}

if($COLUMN < 0) {
	print "Invalid Column entered: $COLUMN\n";
	print "Must be >= 0\n";
	exit;
}

$VALUES = ();
open(CDT, "<$cdt") or die "Can't open $cdt for reading!\n";
$line = "";
while($line = <CDT>) {
	chomp($line);
	push(@VALUES,$line);
}
close CDT;

open(IN, "<$input") or die "Can't open $input for reading!\n";
open(OUT, ">$output") or die "Can't open $output for writing!\n";

# chr4	128375	132375	10001;01_RP	345	-
# chr4	219708	223708	10002;01_RP	385	-

$line = "";
while($line = <IN>) {
	chomp($line);
	if((substr $line, 0, 1) eq "#") {
		print OUT $line,"\n";
	} else {
		@array = split(/\t/, $line);
		my $val = $array[$COLUMN];
		if((first {$_ eq $array[$COLUMN]} @VALUES) && $STATUS eq "keep") {
			print OUT $line,"\n";
		} elsif(!(first {$_ eq $array[$COLUMN]} @VALUES) && $STATUS eq "remove") {
			print OUT $line,"\n";
		}
	}
}
close IN;
close OUT;
