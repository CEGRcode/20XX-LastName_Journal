#! /usr/bin/perl

die "usage:\t\tperl update_BED_score_with_TAB_score.pl\tBED_File (to be updated)\tTAB_File (output from sum_Row_CDT.pl)\tOutput_BED\nExample:\tperl update_BED_score_with_TAB_score.pl input.bed ref.tab output.bed\n" unless $#ARGV == 2;
my($bed, $cdt, $output) = @ARGV;

%SCORE = ();
open(CDT, "<$cdt") or die "Can't open $cdt for reading!\n";
$line = "";
$counter = 1;
while($line = <CDT>) {
        chomp($line);
        @array = split(/\t/, $line);
        if(exists $SCORE{$array[0]}) {
                print "Error!!! ID field exists multiple times in tab file. Unable to update BED file\n";
                print "Line number: $counter\n$line\n";
                exit;
        } else { $SCORE{$array[0]} = $array[1]; }
        $counter++;
}
close BED;

open(BED, "<$bed") or die "Can't open $bed for reading!\n";
open(OUT, ">$output") or die "Can't open $output for writing!\n";

# chr4  128375  132375  10001;01_RP     345     -
# chr4  219708  223708  10002;01_RP     385     -
# chr15 646852  650852  10003;01_RP     433     -
# chr4  307964  311964  10004;01_RP     497     -

$line = "";
while($line = <BED>) {
        chomp($line);
        if((substr $line, 0, 1) eq "#") {
                print OUT $line,"\n";
        } else {
                @array = split(/\t/, $line);
                if(exists $SCORE{$array[3]} ) {
                        $array[4] = $SCORE{$array[3]};
                        print OUT join("\t", @array),"\n";
                } else {
                        print "Error!!! ID in BED file to be updated not found in tab file.\nLine not found: $line\n";
                        exit;
                }
        }
}
close BED;
close OUT;
