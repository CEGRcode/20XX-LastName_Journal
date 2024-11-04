#SBATCH -N 1
#SBATCH --mem=24gb
#SBATCH -t 2:00:00
#SBATCH -A open
#SBATCH -o logs/XXXXXXXXXXXXXX.log.out
#SBATCH -e logs/XXXXXXXXXXXXXX.log.err



# Optionally include the following if you want to do a job array:

#SBATCH --array 1-5

# To use the job array, parameterize your script on the variable $SLURM_ARRAY_TASK_ID