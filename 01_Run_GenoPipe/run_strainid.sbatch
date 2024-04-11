#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 01:00:00
#SBATCH -A open
#SBATCH -o logs/run_strainid.log.out
#SBATCH -e logs/run_strainid.log.err

module load samtools
module load anaconda3
source activate genopipe # load conda environment with GenoPipe dependencies

### CHANGE ME
STRAINID=/path/to/GenoPipe/StrainID
WRK=/path/to/20XX-LastName_Journal/
GENOME=/path/to/sacCer3.fa
###

INPUTBAM=$WRK/data/BAM
OUTPUT=$WRK/01_Run_GenoPipe/strainid

cd $WRK
[ -d logs ] || mkdir logs
[ -d $OUTPUT ] || mkdir $OUTPUT

cd $STRAINID
bash identify-Strain.sh -i $INPUTBAM -v $STRAINID/sacCer3_VCF/ -g $GENOME -o $OUTPUT
