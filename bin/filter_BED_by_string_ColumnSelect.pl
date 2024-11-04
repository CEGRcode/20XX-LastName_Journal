#! /usr/bin/perl

die "usage:\t\tperl filter_BED_by_string_ColumnSelect.pl\tBED_File\tString value\tColumn-Index (0-based)\tkeep/remove\tOutput_BED\nExample:\tperl filter_BED_by_string_ColumnSelect.pl input.bed 01_RP 4 keep output.bed\n" unless $#ARGV == 4;
my($input, $VALUE, $COLUMN, $STATUS, $output) = @ARGV;

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
		if($array[$COLUMN] =~ $VALUE && $STATUS eq "keep") {
			print OUT $line,"\n";
		} elsif($array[$COLUMN] !~ $VALUE && $STATUS eq "remove") {
			print OUT $line,"\n";
		}
	}
}
close IN;
close OUT;
