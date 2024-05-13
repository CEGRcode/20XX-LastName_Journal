# Title-of-Manuscript

### First Author <sup>1</sup>, ... Last Author <sup>1</sup>

<sup>1</sup>Affiliation 1

### Correspondence: email@domain.com

### PMID : [XXXXXXXX](https://pubmed.ncbi.nlm.nih.gov/XXXXXXXX/)
### GEO ID : [XXXXXXXX](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=XXXXXXXX)

## Abstract
Lorem ipsum...

## Table of Contents

### data
Store large files to be globally accessed by the scripts in each directory

### bin
Generalized scripts and executables used by the scripts across these directories

### 00_Download_and_Preprocessing
Align and preprocess raw data to construct BAM file used in this manuscript

### 01_GenoPipe
Perform quality check of datasets to confirm their strain background

### XXXXXXXXX
** Create your own custom sections in new directories, typically for building reference points to peform Tag Pileups on **

### X_Bulk_Processing
Perform bulk execution of standard and repetitive analyses on HPC with Slurm scheduler (parallelized).

### Z_Figures
Copy/organize results from bulk processing into figure-specific directories corresponding to subfigures in the manuscript. Also includes custom/one-off scripts for analysis that didn't need bulk-style execution.

## Dependencies
Describe the set of dependencies used to perform the analysis for this manuscript. For example, you could describe the conda environment initialization:

### Example 1:
Use the following [anaconda](https://anaconda.org/) environment initialization for setting up dependencies
```
conda create -n my-env-name -c bioconda -c conda-forge bedtools bowtie2 bwa cutadapt meme opencv pandas samtools scipy sra-tools wget
```