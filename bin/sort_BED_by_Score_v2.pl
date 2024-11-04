#! /usr/bin/perl

die "usage:\t\tperl sort_BED_by_Score_v2.pl\tBED_File\tdesc/asc (desc = high->low, asc = low->high\tOutput_BED\nExample:\tperl sort_BED_by_Score_v2.pl input.bed asc output.bed\n" unless $#ARGV == 2;
my($input, $ORDER, $output) = @ARGV;

if($ORDER ne "desc" && $ORDER ne "asc") {
        print "Invalid sort-order entered: $ORDER\n";
        print "Only desc or asc allowed\n";
        exit;
}

open(IN, "<$input") or die "Can't open $input for reading!\n";
open(OUT, ">$output") or die "Can't open $output for writing!\n";

# chr4	128375	132375	10001;01_RP	345	-
# chr4	219708	223708	10002;01_RP	385	-
# chr15	646852	650852	10003;01_RP	433	-
# chr4	307964	311964	10004;01_RP	497	-

@BED = ();

$line = "";
while($line = <IN>) {
	chomp($line);
	next if($line  =~ "##");
	@array = split(/\t/, $line);
	push(@BED, {line => $line, score => $array[4]});
}
close IN;
@FINAL = ();
if($ORDER eq "desc") { @FINAL = sort { $$b{'score'} <=> $$a{'score'} } @BED; }
else { @FINAL = sort { $$a{'score'} <=> $$b{'score'} } @BED; }

for($x = 0; $x <= $#FINAL; $x++) {
	print OUT $FINAL[$x]{'line'},"\n";
}
close OUT;
