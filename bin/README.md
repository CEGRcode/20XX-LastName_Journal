
This directory stores generally used scripts and executables.

### ScriptManager-v0.15.jar
Download this is the Java binary executable for ScriptManager that includes a collection of tools including TagPileup which is used to count tags and calculate coverage of samples around reference points.
```
wget https://github.com/CEGRcode/scriptmanager/releases/download/v0.15/ScriptManager-v0.15.jar
```

## Perl scripts

### calculate_BED_ScoreRatio.pl
This script takes two input BED files (numerator BED file and denominator BED file) and writes an output BED entry for each gene in the files where the score column value is the ratio of values from the input files.
```
usage:		perl calculate_BED_ScoreRatio.pl  Numerator_BED_File	Denominator_BED_File	Output_BED
Example:	perl calculate_BED_ScoreRatio.pl numerator.bed denominator.bed ratio.bed
	BED information inherited from numerator BED file
```

### filter_BED_by_list_ColumnSelect.pl
This script filters to keep or remove rows from any input BED (or tab-delimited) file based on the user-specified column values matching a user-specified list of strings.
```
usage:		perl filter_BED_by_list_ColumnSelect.pl	BED_File	List_File_Values	Column-Index (0-based)	keep/remove	Output_BED
Example:	perl filter_BED_by_list_ColumnSelect.pl input.bed ids.tab 4 keep output.bed
```

### filter_BED_by_string_ColumnSelect.pl
This script filters to keep or remove rows from any input BED (or tab-delimited) file based on the user-specified column values matching a user-specified string.
```
usage:		perl filter_BED_by_string_ColumnSelect.pl	BED_File	String value	Column-Index (0-based)	keep/remove	Output_BED
Example:	perl filter_BED_by_string_ColumnSelect.pl input.bed 01_RP 4 keep output.bed
```

### filter_BED_by_value_ColumnSelect.pl
This script filters to keep or remove rows from any input BED (or tab-delimited) file based on the user-specified column values being greater than or less than a numeric value.
```
usage:		perl filter_BED_by_value_ColumnSelect.pl	BED_File	Value (>=)	Column-Index (0-based)	keep/remove	Output_BED
Example:	perl filter_BED_by_value_ColumnSelect.pl input.bed 500 4 keep output.bed
```

### sort_BED_by_Score_v2.pl
This script sorts the entries in a BED file by the score column (5th column, index-4) in either ascending or descending order.
```
usage:		perl sort_BED_by_Score_v2.pl	BED_File	desc/asc (desc = high->low, asc = low->high	Output_BED
Example:	perl sort_BED_by_Score_v2.pl input.bed asc output.bed
```

### sum_Col_CDT.pl
This script sums the columns of a CDT matrix file by column values (CDT to composite).
```
usage:		perl sum_Col_CDT.pl	Input_CDT_File	Output_TAB_File
Example:	perl sum_Col_CDT.pl input.cdt composite.out
```

### update_BED_coord.pl
This script updates an input BED file with the coordinates of master BED file (lookup by identifier, 4th column, index-3).
```
usage:		perl update_BED_coord.pl	BED_File (to be updated)	BED_File (master list)	Output_BED
Example:	perl update_BED_coord.pl input.bed master.bed output.bed
```

### update_BED_score_with_TAB_score.pl
This script updates an input BED file's score column (5th column, index-4) with values from a 2-column tab-delimited input lookup ("id\tvalue").
```
usage:		perl update_BED_score_with_TAB_score.pl	BED_File (to be updated)	TAB_File (output from sum_Row_CDT.pl)	Output_BED
Example:	perl update_BED_score_with_TAB_score.pl input.bed ref.tab output.bed
```

## Python scripts

### make_fragment_histograms.py
Make SVG formatted plots from the command line using ScriptManager-formatted inputs (from `pe-stats` tool.)

```
usage: make_fragment_histograms.py [-h] -i input_fn [--scientific] [--max-y value] -o png_fn

Build insert-size histograms from ScriptManager bam-statistics pe-stats output.

options:
  -h, --help            show this help message and exit
  -i input_fn, --input input_fn
                        the "*InsertHistogram.out" file listing insert size counts
  --scientific          label the y-axis with full numbers, not converted to scientific notation
  --max-y value         label the y-axis with full numbers, not converted to scientific notation
  -o png_fn, --output png_fn
                        the output figure image (use .svg or .png)
```