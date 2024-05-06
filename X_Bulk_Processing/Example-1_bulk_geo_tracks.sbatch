#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 00:15:00
#SBATCH -A open
#SBATCH -o logs/Example-1_bulk_geo_tracks.log.out-%a
#SBATCH -e logs/Example-1_bulk_geo_tracks.log.err-%a
#SBATCH --array 1-NSAMPLES

# SLURM_ARRAY_TASK_ID=2

# Cross all BED x all BAM to generate BigWig tracks that can be uploaded to GEO

### CHANGE ME
WRK=/path/to/20XX-LastName_Journal/X_Bulk_Processing
###

# Dependencies
# - java
# - samtools

set -exo
module load samtools
module load anaconda3
source activate my-env

# Fill in placeholder constants with your directories
FDIR=$WRK/data/NormalizationFactors
BAMDIR=$WRK/data/BAM
OUTDIR=$WRK/Tracks
MD5=$WRK/Checksums
CHRMSZ=$WRK/data/sacCer3.chrom.sizes

# Setup ScriptManager for job array
ORIGINAL_SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14.jar
SCRIPTMANAGER=$WRK/bin/ScriptManager-v0.14-$SLURM_ARRAY_TASK_ID.jar
cp $ORIGINAL_SCRIPTMANAGER $SCRIPTMANAGER

# Script shortcuts
SCRIPTMANAGER=/path/to/ScriptManager-v0.14.jar
COMPOSITE=$WRK/bin/sum_Col_CDT.pl
BGTOBW=$WRK/bin/bedGraphToBigWig

# Set up output directories
[ -d logs ] || mkdir logs
[ -d $OUTDIR ] || mkdir $OUTDIR

# Determine BAM file for the current job array index
BAMFILE=`ls $BAMDIR/*.bam | head -n $SLURM_ARRAY_TASK_ID |tail -1`
BAM=`basename $BAMFILE ".bam"`
[ -f $BAMFILE.bai ] || samtools index $BAMFILE

# Determine Scaling factor
FACTOR=1
# FACTOR=`grep 'Scaling factor' $WRK/data/NormalizationFactors/$BAM\_NCISb_ScalingFactors.out | awk -F" " '{print $3}'`

# Determine BAM file for the current job array index
#BAMFILE=`ls $BAMDIR/*.bam | grep -f 00_Download_and_preprocessing/stable4.txt |head -n $SLURM_ARRAY_TASK_ID |tail -1`
BAM=`basename $BAMFILE ".bam"`
TYPE=`echo $BAM |cut -d"_" -f2`
TEMP=$OUTDIR/$BAM
BASE=$BAM\_read1

[ -d $OUTDIR ] || mkdir $OUTDIR
[ -d $TEMP ] || mkdir $TEMP

echo "Build BigWig: $BAMFILE"

# BAM to ScIdx
java -jar $SCRIPTMANAGER bam-format-converter bam-to-scidx $BAMFILE -o $TEMP/$BASE.raw.tab

# Clean-up and scale
grep -v -f $CHRMSZ $TEMP/$BASE.raw.tab > $TEMP/$BASE.filtered.tab
java -jar $SCRIPTMANAGER read-analysis scale-matrix $TEMP/$BASE.filtered.tab -s $FACTOR -r 2 -o $TEMP/$BASE.scaled.tab

# Convert to sense/anti Bedgraph tracks
sed '1d;2d' $TEMP/$BASE.scaled.tab | awk '{OFS="\t"}{FS="\t"}{print $1, $2, $2+1, $3}' |sort -k1,1 -k2,2n > $TEMP/$BASE.forward.bedgraph
sed '1d;2d' $TEMP/$BASE.scaled.tab | awk '{OFS="\t"}{FS="\t"}{print $1, $2, $2+1, $4}' |sort -k1,1 -k2,2n > $TEMP/$BASE.reverse.bedgraph

# Compress to BigWig format
$BGTOBW $TEMP/$BASE.forward.bedgraph $CHRMSZ $OUTDIR/$BASE.forward.bw
$BGTOBW $TEMP/$BASE.reverse.bedgraph $CHRMSZ $OUTDIR/$BASE.reverse.bw

# Get Checksums
md5sum $OUTDIR/$BASE.forward.bw > $MD5/$BASE.forward.bw.mdsum
md5sum $OUTDIR/$BASE.reverse.bw > $MD5/$BASE.reverse.bw.mdsum
