

This directory includes the bash and PBS scripts for downloading and preprocessing the sequencing samples for analysis throughout the rest of this repo.


The following scripts should be executed in numerical order. The user should update the working directory (`$WRK`) filepath variable within every script before executing.

### Download ScriptManager
Make sure you download ScriptManager and move it to `/path/to/20XX-LastName_Journal/bin/`.
```
wget https://github.com/CEGRcode/scriptmanager/releases/download/v0.14/ScriptManager-v0.14.jar
mv ScriptManager-v0.14.jar ../bin/
```

### Download Master NoTag from YEP (yeast)
Download and index the control NoTag sample used in Rossi et al, 2021 (Nature).
```
wget https://www.datacommons.psu.edu/download/eberly/pughlab/yeast-epigenome-project/masterNoTag_20180928.zip
unzip masterNoTag_20180928.zip
mv masterNoTag_20180928.bam data/BAM/
samtools index data/BAM/masterNoTag_20180928.bam
rm masterNoTag_20180928.zip
```

### Download YEP Blacklist (yeast)
Download the normalization blacklist used in Rossi et al, 2021 (Nature).
```
wget https://raw.githubusercontent.com/CEGRcode/2021-Rossi_Nature/master/02_References_and_Features_Files/ChExMix_Peak_Filter_List_190612.bed
mv ChExMix_Peak_Filter_List_190612.bed ../data/
```

### 1_download_data.sh
Describe how to run scripts or direct download data.

### 2_align_samples.pbs
Describe how to align data or use scripts saved here to align data.

### 3_normalize_samples.sh
Describe how to calculate normalization factors for your align data. (need notag BAM and blacklist BED to run)
