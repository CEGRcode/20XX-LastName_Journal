

This directory includes the bash and PBS scripts for downloading and preprocessing the sequencing samples for analysis throughout the rest of this repo.


The following scripts should be executed in numerical order. The user should update the working directory (`$WRK`) filepath variable within every script before executing.

### Edit `mysamples.txt` to include the list of PEGR samples you wish to analyze
This list of ids is used by the `1_download_data.sh` script to retrieve FASTQ/BAM files from PEGR.

### 1_download_data.sh
Download FASTQ/BAM files from PEGR using the [EGC_utility_scripts](https://github.com/CEGRcode/EGC_utility_scripts) repo's `generate_BAM_file_from_PEGR.py`. You may modify this to also include other data downloaded from public repositories.

### 2_align_samples.pbs
Describe how to align data or use scripts saved here to align data.

### 3_normalize_samples.sh
Describe how to calculate normalization factors for your aligned data.

```
# ^change the number of BAM files samples (PBS -t)
# To execute, type
# qsub 3_normalize_samples.sh
##
# To check status, type
# qstat -u <myusername> -t
```
