
## Archived scripts for reference purposes


### (Not Recommended) make_excel_composite_v2.py
*Note: Please use [Locus Plotter](https://github.com/CEGRcode/plotter) for building composites instead of the excel tool.*

Concatenate all composite files from an input directory into a formatted Excel file to use with Excel plotting tool.

```
usage: make_excel_composite_v2.py [-h] -i composite-dir -o outfile

This script takes a directory of composite (*.out) files and combines them into an excel spreadsheet.

optional arguments:
  -h, --help                                    show this help message and exit
  -i <composite-dir>, --input <composite-dir>   directory with all the composite data files
  -o <outfile>, --output <outfile>              output name to save workbook to
```