#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 00:15:00
#SBATCH -A open
#SBATCH -o logs/Example-2_bulk_tagpileup.log.out-%a
#SBATCH -e logs/Example-2_bulk_tagpileup.log.err-%a
#SBATCH --array 1-NSAMPLES

# SLURM_ARRAY_TASK_ID=2

# Cross all BED x all BAM to run some scripts (typically TagPileup)

### CHANGE ME
WRK=/path/to/20XX-LastName_Journal/X_Bulk_Processing
###

# Dependencies
# - java
# - samtools

set -exo
module load samtools
module load anaconda3

# Fill in placeholder constants with your directories
FDIR=$WRK/data/NormalizationFactors
BAMDIR=$WRK/data/BAM
BEDDIR=$WRK/data/BED
OUTDIR=$WRK/Library

# Setup ScriptManager for job array
ORIGINAL_SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14.jar
SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14-$SLURM_ARRAY_TASK_ID.jar
cp $ORIGINAL_SCRIPTMANAGER $SCRIPTMANAGER

# Script shortcuts
COMPOSITE=$WRK/bin/sum_Col_CDT.pl

# Set up output directories
[ -d logs ] || mkdir logs
[ -d $OUTDIR ] || mkdir $OUTDIR

# Determine BAM file for the current job array index
BAMFILE=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $4}'`
BAM=`basename $BAMFILE ".bam"`
[ -f $BAMFILE.bai ] || samtools index $BAMFILE

# Process BAM file for each BED file in directory
for BEDFILE in `ls $BEDDIR/*1000bp.bed`;
do
	echo $BEDFILE
	BED=`basename $BEDFILE ".bed"`
	DIR=$OUTDIR/$BED
	[ -d $DIR ] || mkdir $DIR

	# Do stuff here

	# # Example TF Pileup:
	# [ -d $DIR/COMPOSITES ] || mkdir $DIR/COMPOSITES
	# [ -d $DIR/CDT ] || mkdir $DIR/CDT
	# [ -d $DIR/NormComposites ] || mkdir $DIR/NormComposites
	# BASE=$BAM\_$BED\_read1
	# # Get Scaling Factor
	# FACTOR=`grep 'Scaling factor' $FDIR/$BAM\_NCISb_ScalingFactors.out | awk -F" " '{print $3}'`
	# # Pileup
	# java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDFILE $BAMFILE --cpu 4 -o $DIR/COMPOSITES/$BASE.raw.out -M $DIR/CDT/$BASE
	# # Scale pileups
	# java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/CDT/$BASE\_anti.cdt -s $FACTOR -o $DIR/CDT/$BASE\_anti_Normalized.cdt
	# java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/CDT/$BASE\_sense.cdt -s $FACTOR -o $DIR/CDT/$BASE\_sense_Normalized.cdt
	# # Column-wise sum normalized CDTs into composites
	# perl $COMPOSITE $DIR/CDT/$BASE\_anti_Normalized.cdt $DIR/CDT/$BASE\_ANTI
	# perl $COMPOSITE $DIR/CDT/$BASE\_sense_Normalized.cdt $DIR/CDT/$BASE\_SENSE
	# # Merge into same normalized file and remove intermediates
	# cat $DIR/CDT/$BASE\_ANTI <(tail -1 $DIR/CDT/$BASE\_SENSE) > $DIR/NormComposites/$BASE\_Normalized.out
	# rm $DIR/CDT/$BASE\_SENSE $DIR/CDT/$BASE\_ANTI
done
