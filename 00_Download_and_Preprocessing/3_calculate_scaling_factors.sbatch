#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 00:10:00
#SBATCH -A open
#SBATCH -o logs/3_calculate_scaling_factors.log.out-%a
#SBATCH -e logs/3_calculate_scaling_factors.log.err-%a
#SBATCH --array 1-NSAMPLES

# Calculate normalization factor for every *.bam file in a directory

### CHANGE ME
#SLURM_ARRAY_TASK_ID=1
WRK=/path/to/20XX-LastName_Journal/
BAMDIR=$WRK/data/BAM
BEDDIR=$WRK/data/BED
FDIR=$WRK/data/BAM/NormalizationFactors
BLACKLIST=$WRK/data/sacCer3_files/ChExMix_Peak_Filter_List_190612.bed
CONTROL=$WRK/data/BAM/masterNoTag_20180928.bam
###

module load gcc
module load samtools
module load anaconda3
#source activate my-env

# Setup ScriptManager for job array
ORIGINAL_SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14.jar
SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14-$SLURM_ARRAY_TASK_ID.jar
cp $ORIGINAL_SCRIPTMANAGER $SCRIPTMANAGER

# Script shortcuts
# (none)

# Set up output directories
cd $WRK
[ -d logs ] || mkdir logs
[ -d $FDIR ] || mkdir $FDIR

# Determine BAM file for the current job array index
BAMFILE=`ls $BAMDIR/*.bam | head -n $SLURM_ARRAY_TASK_ID | tail -1`;
BAM=`basename $BAMFILE ".bam"`
[ -f $BAMFILE.bai ] || samtools index $BAMFILE

# Use different normalization method depending on target/assay
# This script ONLY covers NCIS (for TF ChIPs), if your data includes NUCLEOSOME data, USE NFR normalization!
echo "Calculate classic TF NCIS normalization factors w/ blacklist"
java -jar $SCRIPTMANAGER read-analysis scaling-factor $BAMFILE -f $BLACKLIST --ncis -c $CONTROL -w 500 -o $FDIR/$BAM\_NCISb

rm $SCRIPTMANAGER
