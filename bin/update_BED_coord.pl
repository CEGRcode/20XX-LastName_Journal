#! /usr/bin/perl

die "usage:\t\tperl update_BED_coord.pl\tBED_File (to be updated)\tBED_File (master list)\tOutput_BED\nExample:\tperl update_BED_coord.pl input.bed master.bed output.bed\n" unless $#ARGV == 2;
my($bed1, $bed2, $output) = @ARGV;

%COORD = ();
open(BED, "<$bed2") or die "Can't open $bed2 for reading!\n";
$line = "";
$counter = 1;
while($line = <BED>) {
	chomp($line);
	@array = split(/\t/, $line);
	if(exists $COORD{$array[3]}) {
		print "Error!!! ID field exists multiple times in master list. Unable to update coordinates\n";
		print "Line number: $counter\n$line\n";
		exit;
	} else { $COORD{$array[3]} = $line; }
	$counter++;
}
close BED;

open(BED, "<$bed1") or die "Can't open $bed1 for reading!\n";
open(OUT, ">$output") or die "Can't open $output for writing!\n";

# chr4	128375	132375	10001;01_RP	345	-
# chr4	219708	223708	10002;01_RP	385	-
# chr15	646852	650852	10003;01_RP	433	-
# chr4	307964	311964	10004;01_RP	497	-

$line = "";
while($line = <BED>) {
	chomp($line);
	if((substr $line, 0, 1) eq "#") {
                print OUT $line,"\n";
        } else {
		@array = split(/\t/, $line);
		if(exists $COORD{$array[3]} ) {
			@newCOORD = split(/\t/, $COORD{$array[3]});
			$array[0] = $newCOORD[0];
			$array[1] = $newCOORD[1];
			$array[2] = $newCOORD[2];
			$array[5] = $newCOORD[5];
			print OUT join("\t", @array),"\n";
		} else {
			print "Error!!! ID in BED file to be updated not found in master list.\nLine not found: $line\n";
			exit;
		}
	}
}
close BED;
close OUT;
