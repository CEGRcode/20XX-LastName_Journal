#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=24gb
#SBATCH -t 00:40:00
#SBATCH -A open
#SBATCH -o logs/Example-4_endo_read_pileups.log.out-%a
#SBATCH -e logs/Example-4_endo_read_pileups.log.err-%a
#SBATCH --array 1-36

# Pileup read2 (endo cut sites) for a custom combinations of BAM x BED files.
# Heatmaps included and all with NCIS scaling. Read2 sense/anti flipped for plotting.

### CHANGE ME
WRK=/path/to/20XX-LastName_Journal/X_Bulk_Processing
METADATA=Read2_pileups.txt
THREADS=4
###

# Dependencies
# - java
# - perl
# - samtools

set -exo
module load samtools

# Inputs and outputs
BAMDIR=$WRK/../data/BAM
OUTDIR=$WRK/Library

# Setup ScriptManager for job array
ORIGINAL_SCRIPTMANAGER=$WRK/../bin/ScriptManager-v0.15.jar
SCRIPTMANAGER=$WRK/../bin/ScriptManager-v0.15-$SLURM_ARRAY_TASK_ID.jar
cp $ORIGINAL_SCRIPTMANAGER $SCRIPTMANAGER

# Script shortcuts
COMPOSITE=$WRK/../bin/sum_Col_CDT.pl

# Set up output directories
[ -d logs ] || mkdir logs
[ -d $OUTDIR ] || mkdir $OUTDIR

# Determine absolute contrast threshold
ATHRESH=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $1}'`

# Determine BAM file for the current job array index
BAMFILE=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $2}'`
BAM=`basename $BAMFILE ".bam"`
[ -f $BAMFILE.bai ] || samtools index $BAMFILE

# Determine BED file for the current job array index
BEDFILE=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $3}'`
BED=`basename $BEDFILE ".bed"`

echo "(${SLURM_ARRAY_TASK_ID}) ${BEDFILE} "x" ${BAMFILE} "

DIR=$OUTDIR/$BED
[ -d $DIR ] || mkdir $DIR
[[ -d $DIR/CDT ]] || mkdir $DIR/CDT
[[ -d $DIR/Composites ]] || mkdir $DIR/Composites

# Get scaling factor
FACTOR=`grep 'Scaling factor' $BAMDIR/NormalizationFactors/$BAM\_NCISb_ScalingFactors.out | awk -F" " '{print $3}'`

echo "Run Custom read2 pileup"
BASE=$BAM\_$BED\_5read2

# Pileup (Read 2)
java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDFILE $BAMFILE --cpu 4 -5 -2 -o $DIR/Composites/$BASE.out -M $DIR/CDT/$BASE
java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/CDT/$BASE\_anti.cdt  -s $FACTOR -o $DIR/CDT/$BASE\_anti_Normalized.cdt
java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/CDT/$BASE\_sense.cdt -s $FACTOR -o $DIR/CDT/$BASE\_sense_Normalized.cdt

# Two-color heatmap & merge
java -jar $SCRIPTMANAGER figure-generation heatmap -a $ATHRESH -c FF00FF $DIR/CDT/$BASE\_sense_Normalized.cdt -o $DIR/PNG/Strand/$BASE\_sense_Normalized_treeview.png
java -jar $SCRIPTMANAGER figure-generation heatmap -a $ATHRESH -c 00BFFF  $DIR/CDT/$BASE\_anti_Normalized.cdt  -o $DIR/PNG/Strand/$BASE\_anti_Normalized_treeview.png
java -jar $SCRIPTMANAGER figure-generation merge-heatmap $DIR/PNG/Strand/$BASE\_sense_Normalized_treeview.png $DIR/PNG/Strand/$BASE\_anti_Normalized_treeview.png -o $DIR/PNG/$BASE\_Normalized_merge.png

# Count sites
NSITES=`wc -l $BEDFILE | awk '{print $1-1}'`

# Label heatmap based on BED naming
if [[ "$BED" == *"1000bp"* ]]; then  
    java -jar "$SCRIPTMANAGER" figure-generation label-heatmap "$DIR/PNG/${BASE}_Normalized_merge.png" \
        -l "-500" -m "0" -r "+500" -w 1 -f 20 \
        -o "$DIR/SVG/${BASE}_Normalized_merge_label.svg"

elif [[ "$BED" == *"500bp"* ]]; then  
    java -jar "$SCRIPTMANAGER" figure-generation label-heatmap "$DIR/PNG/${BASE}_Normalized_merge.png" \
        -l "-250" -m "0" -r "+250" -w 1 -f 20 \
        -o "$DIR/SVG/${BASE}_Normalized_merge_label.svg"

elif [[ "$BED" == *"250bp"* ]]; then  
    java -jar "$SCRIPTMANAGER" figure-generation label-heatmap "$DIR/PNG/${BASE}_Normalized_merge.png" \
        -l "0" -m "125" -r "+250" -w 1 -f 20 \
        -o "$DIR/SVG/${BASE}_Normalized_merge_label.svg"
fi

# Make stranded composites (need to swap sense/anti labels for locus plotter if read2)
perl $COMPOSITE $DIR/CDT/$BASE\_anti_Normalized.cdt $DIR/CDT/$BASE\_ANTI
perl $COMPOSITE $DIR/CDT/$BASE\_sense_Normalized.cdt $DIR/CDT/$BASE\_SENSE
head -1 $DIR/CDT/$BASE\_ANTI > $DIR/Composites/$BASE\_Normalized.out
paste <(echo $BASE\_Normalized_sense_RESTRANDED.cdt ) <(tail -1 $DIR/CDT/$BASE\_ANTI | cut -f2-10010 ) >> $DIR/Composites/$BASE\_Normalized.out
paste <(echo $BASE\_Normalized_anti_RESTRANDED.cdt ) <(tail -1 $DIR/CDT/$BASE\_SENSE | cut -f2-10010 ) >> $DIR/Composites/$BASE\_Normalized.out
rm $DIR/CDT/$BASE\_SENSE $DIR/CDT/$BASE\_ANTI