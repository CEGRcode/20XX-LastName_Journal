

This directory includes the GenoPipe results and the scripts for generating and parsing the results. To run these scripts, be sure to update the file paths to both the current working directory and to the GenoPipe directory.

Update the two paths before running:
```
WRK=/path/to/20XX-LastName_Journal/
MODULEID=/path/to/GenoPipe/ModuleID
```

After running, the directory should have the following directory structure:
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
