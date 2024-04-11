#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 01:00:00
#SBATCH -A open
#SBATCH -o logs/run_epitopeid.log.out
#SBATCH -e logs/run_epitopeid.log.err

module load samtools
module load anaconda3
source activate genopipe # load conda environment with GenoPipe dependencies

### CHANGE ME
EPITOPEID=/path/to/GenoPipe/EpitopeID
WRK=/path/to/20XX-LastName_Journal/
###

INPUTFQ=$WRK/data/FASTQ
OUTPUT=$WRK/01_Run_GenoPipe/epitopeid

cd $WRK
[ -d logs ] || mkdir logs
[ -d $OUTPUT ] || mkdir $OUTPUT

cd $EPITOPEID
bash identify-Epitope.sh -i $INPUTFQ -o $OUTPUT -d $EPITOPEID/sacCer3_EpiID -t 6
