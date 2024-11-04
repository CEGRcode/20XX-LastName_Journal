#! /usr/bin/perl

die "usage:\t\tperl calculate_BED_ScoreRatio.pl\tNumerator_BED_File\tDenominator_BED_File\tOutput_BED\nExample:\tperl calculate_BED_ScoreRatio.pl numerator.bed denominator.bed ratio.bed\n\tBED information inherited from numerator BED file\n" unless $#ARGV == 2;
my($bed1, $bed2, $output) = @ARGV;

$linecount1 = 0;
open(BED1, "<$bed1") or die "Can't open $bed1 for reading!\n";
$line = "";
while($line = <BED1>) {
	chomp($line);
        next if((substr $line, 0, 1) eq "#");
	$linecount1++;
}
close BED1;

$linecount2 = 0;
open(BED2, "<$bed2") or die "Can't open $bed2 for reading!\n";
$line = "";
while($line = <BED2>) {
        chomp($line);
        next if((substr $line, 0, 1) eq "#");
        $linecount2++;
}

if($linecount1 != $linecount2) {
	print "Error!!!\nNumerator BED file line count: $linecount1\nDenominator BED file count: $linecount2\n";
	exit;
}

open(BED1, "<$bed1") or die "Can't open $bed1 for reading!\n";
open(BED2, "<$bed2") or die "Can't open $bed2 for reading!\n";
open(OUT, ">$output") or die "Can't open $output for writing!\n";

# chr4	128375	132375	10001;01_RP	345	-
# chr4	219708	223708	10002;01_RP	385	-

# chr15	646852	650852	10003;01_RP	433	-
# chr4	307964	311964	10004;01_RP	497	-

$line1 = $line2 = "";
while($line1 = <BED1>) {
	$line2 = <BED2>;
	chomp($line1);
	chomp($line2);

        next if((substr $line1, 0, 1) eq "#");
        next if((substr $line2, 0, 1) eq "#");

	@array1 = split(/\t/, $line1);
	@array2 = split(/\t/, $line2);

	if($array2[4] == 0) { $RATIO = "NaN"; }
	else { $RATIO = $array1[4] / $array2[4]; }
	$array1[4] = $RATIO;
	print OUT join("\t",@array1),"\n";
}
close BED1;
close BED2;
close OUT;
