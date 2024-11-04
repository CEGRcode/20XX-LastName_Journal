#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=14gb
#SBATCH -t 00:15:00
#SBATCH -A open
#SBATCH -o logs/0_Template-Slurm-Config-Script.log.out
#SBATCH -e logs/0_Template-Slurm-Config-Script.log.err
#SBATCH --array 1-3

# Describe what this script generally does here. This is is a template script for customizing your own config-style bulk execution

### CHANGE ME
WRK=/path/to/20XX-LastName_Journal/X_Bulk_Processing ## edit to match the path to your project directory ##
METADATA=Template-Generic.txt ## you can indicate a config file ##
###

# Dependencies
# - java
# - List out all your dependencies here in a comment

set -exo # this line is useful for logging/debugging purposes but not necessary
module load bedtools # some "installation" commands for dependencies you want to use. These work for Penn State's ROAR collab systems but not necessarily for other computers
module load bwa
module load samtools
module load anaconda3
source activate my-env # You can create a conda environment and activate it with a command like this one (replace my-env with your environment name)

# Inputs and outputs
OUTDIR=myoutput
## your filepaths to inputs or outputs used in this script. Above is an example ##

# Script shortcuts
## path locations for script you want to use. I recommend storing scripts like the ScriptManager JAR in the 20XX-LastName_Journal/bin folder. ##
SCRIPTMANAGER=../bin/ScriptManager-v0.15.jar

# Set up output directories
[ -d logs ] || mkdir logs ## check if log directory exists and make it if it doesn't ##
[ -d $OUTDIR ] || mkdir $OUTDIR

# Determine the first field for the current job array index
FIELD1=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $1}'`

# Determine the second field for the current job array index
FIELD2=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $2}'`

# Determine the third field for the current job array index
FIELD3=`sed "${SLURM_ARRAY_TASK_ID}q;d" $METADATA | awk '{print $2}'`

# ===============

# Do stuff here! Whatever you want to do for your analysis

# FAQs and tips:
#  - If you're stuck, check out the other examples in this directory for analysis ideas, esp around script structure.
#  - If you don't understand something in the examples, try plugging it into ChatGPT to give you a summary of what it does.
#  - If your script is terminating early for some reason, check the SLURM header. You may need to give it more time/memory/CPUs.