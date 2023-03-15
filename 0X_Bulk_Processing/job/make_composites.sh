#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -l pmem=14gb
#PBS -l walltime=00:15:00
#PBS -A open
#PBS -o logs/make_excel.log.out
#PBS -e logs/make_excel.log.err

module load gcc
module load samtools
module load anaconda3

# Concatenate all normalized composites of a shared reference to a single excel file

### CHANGE ME
source activate my-env # load conda environment with GenoPipe dependencies
WRK=/path/to/20XX-LastName_Journal/
BEDDIR=$WRK/data/BED
OUTDIR=$WRK/Output
###

# Script shortcuts
MAKE=$WRK/bin/make_excel_composite_v2.py

# Set up output directories
cd $WRK

# Process BAM file for each BED file in directory
for BEDFILE in `ls $BEDDIR/*1000bp.bed`;
do
	echo \#$BEDFILE
	BED=`basename $BEDFILE ".bed"`
	DIR=$OUTDIR/$BED

	echo python $MAKE -i $DIR/NormComposites -o $DIR/$BED.xlsx
done
