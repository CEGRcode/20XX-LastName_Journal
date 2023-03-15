

This directory includes the GenoPipe results and the scripts for generating and parsing the results. To run these scripts, be sure to update the file paths to both the current working directory and to the GenoPipe directory.

Update the two paths before running:
```
WRK=/path/to/20XX-LastName_Journal/
MODULEID=/path/to/GenoPipe/ModuleID
```

After running, the directory should have the following directory structure:

<details>
<summary> Directory Structure
</summary>

```
|--01_Run_GenoPipe
  |--job
    |--run_deletionid.pbs
    |--run_epitopeid.pbs
    |--run_strainid.pbs
  |--logs
    |--run_epitopeid.log.err
    |--run_epitopeid.log.out
    |--run_deletionid.log.err
    |--run_deletionid.log.out
    |--run_strainid.log.err
    |--run_strainid.log.out
  |--epitopeid
    |--XXXX-R1.tab
    ...
  |--deletionid
    |--XXXX_deletion.tab
    ...
  |--strainid
    |--XXXX_strain.tab
    ...
```

</details>

## Getting Started Checklist

Below is a brief checklist of tasks to setup GenoPipe. For more help or information on customization, [read the docs]:(https://pughlab.mbg.cornell.edu/GenoPipe-docs/)

- Clone & set-up GenoPipe
  - install/setup GenoPipe dependencies
  - download references like ref genome and place in appropriate dirs
- update `job` scripts (`run_epitopeid.pbs`, `run_deletionid.pbs`, `run_strainid.pbs`) with the pathnames
  - to GenoPipe
  - to current working directory
  - to genome (only StrainID)
- make sure FASTQ/BAM files are downloaded to specified path
- Execute!


## Running scripts

Each of the `job` scripts is set-up to run a different default GenoPipe module. Consider which one you need. Make sure path names within the `### CHANGE ME` comments are updated.

### For few samples
If you don't have a lot of samples and the samples are really small, GenoPipe will run in a reasonable amount of time so you could simply run the following command in the shell and wait for it to finish.

Example:
```
bash job/run_epitopeid.pbs
```

### For many/large samples

If you need more time, the script is set-up to run on servers with a PBS scheduler. Make sure the walltime you request is reasonable (`#PBS -l walltime=`) and that you are using the appropriate allocation (`#PBS -A`).

Example:
```
qsub job/run_epitopeid.pbs
```
