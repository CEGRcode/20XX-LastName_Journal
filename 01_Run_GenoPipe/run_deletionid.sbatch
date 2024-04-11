#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 01:00:00
#SBATCH -A open
#SBATCH -o logs/run_deletionid.log.out
#SBATCH -e logs/run_deletionid.log.err

module load samtools
module load anaconda3
source activate genopipe # load conda environment with GenoPipe dependencies

### CHANGE ME
DELETIONID=/path/to/GenoPipe/DeletionID
WRK=/path/to/20XX-LastName_Journal/
###

INPUTBAM=$WRK/data/BAM
OUTPUT=$WRK/01_Run_GenoPipe/deletionid

cd $WRK
[ -d logs ] || mkdir logs
[ -d $OUTPUT ] || mkdir $OUTPUT

cd $DELETIONID
bash identify-Deletion.sh -i $INPUTBAM -d $DELETIONID/sacCer3_Del/ -o $OUTPUT
