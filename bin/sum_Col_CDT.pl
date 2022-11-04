#! /usr/bin/perl/

# Make composite file from CDT

die "usage:\t\tperl sum_Col_CDT.pl\tInput_CDT_File\tOutput_TAB_File\nExample:\tperl sum_Col_CDT.pl input.cdt composite.out\n" unless $#ARGV == 1;
my($input, $output) = @ARGV;
open(IN, "<$input") or die "Can't open $input for reading!\n";
open(OUT, ">$output") or die "Can't open $output for reading!\n";

my $NLINE = 0;
my $NCOL = 0;
my @Y;
while(<IN>) {
	chomp;
	my @temparray = split(/\t/, $_);
	if(/YORF/) {
		print OUT join("\t",@temparray[1..$#temparray]),"\n";
		$NCOL = $#temparray;
		next;
	}
	if($NCOL!=$#temparray){
		print "Error!!! Inconsistent CDT window size\n";
		print "(Num Columns=",$#temparray,")",join("\t",@temparray);
		exit;
	}
	for($x = 2; $x <= $#temparray; $x++) {
		$Y[$x-2] += $temparray[$x];
	}
	$NLINE++;
}

for($t = 0; $t <= $#Y; $t++) {
	$Y[$t] = $Y[$t]/$NLINE;
}

print OUT $input,"\t",join("\t",@Y),"\n";

close IN;
close OUT;
