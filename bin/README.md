
This directory stores generally used scripts and executables.

### ScriptManager-v0.14.jar
Download this is the Java binary executable for ScriptManager that includes a collection of tools including TagPileup which is used to count tags and calculate coverage of samples around reference points.
```
wget https://github.com/CEGRcode/scriptmanager/releases/download/v0.14/ScriptManager-v0.14.jar
```

### bedGraphToBigWig
Download the appropriate binary for your OS from UCSC.

### sum_Col_CDT.pl
This script sums the columns of a CDT matrix file by column values (CDT to composite).
```
usage:		perl sum_Col_CDT.pl	Input_CDT_File	Output_TAB_File
Example:	perl sum_Col_CDT.pl input.cdt composite.out
```

### generate_BAM_file_from_PEGR.py
Download this script from `EGC_utility_scripts` repository.

### generate_FQ_file_from_PEGR.py
Download this script from `EGC_utility_scripts` repository.


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