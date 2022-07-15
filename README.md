# rDD-PIPE

To users: we will realiease the source code later.

## 0. Operation system
```
# This pipeline is running in an Ubuntu 20.04 for rDD library processing
```
## 1. Create a Directory as working-dir for running rDD library

```{bash eval=FALSE, include=TRUE}
# for example
$ mkdir /mnt/hgfs/script/rDDPP

```

## 2. Link FASTQ files
```{bash eval=FALSE, include=TRUE}
# jump into the working-dir
$ cd /mnt/hgfs/script/rDDPP

# create a folder to contain FASTQ files
$ mkdir  FQ.demo/
$ cd FQ.demo/

# copy files to this folder
$ cp /path-to-fastq/GM12878_rDD_v-snoRNA1_rep3_BR_1.fq.gz .
$ cp /path-to-fastq/GM12878_rDD_v-snoRNA1_rep3_BR_2.fq.gz .

# or softlink
$ ln -s /path-to-fastq/GM12878_rDD_v-snoRNA1_rep3_BR_1.fq.gz
$ ln -s /path-to-fastq/GM12878_rDD_v-snoRNA1_rep3_BR_2.fq.gz
```

## 3. Install supported softwares
```{bash eval=FALSE, include=TRUE}
$ sh PRE01_install_soft.sh
```

## 4. Generate reference genome (hg38-EBV.B958)
```{bash eval=FALSE, include=TRUE}
$ sh PRE02_hg38B_genome.sh
```
## 5. Modify the configuration file
```{bash eval=FALSE, include=TRUE}
# modify the information in the following config file without execution.

$ vim PRE03_config.sh

"""
......
echo "NTHREAD=14" > $FC   ## cores you want to use to run this pipeline.
echo "MEM=32g" >$FC  ## RAM you want to use to run this pipeline.
echo "LINKER=LR" >$FC  ## select linker types from:  BR, LR.
echo "fasta="${PIPEDIR}"/ref_genome/hg38B/hg38B.fa" > $FC  
                                           ## reference genome fasta file
echo "genome="${PIPEDIR}"/genome_size/hg38B.fa.size" > $FC 
                                                  ## reference genome size
echo "SPLT=Y" >$FC  
              ## split loops and coverage by species (hg38-EBV): Y=yes; N=not. 
......
"""

```

## 6. Run rDD-PIPE pipeline
```{bash eval=FALSE, include=TRUE}
$ sh RDD00_RUN_rDDPP.sh

> please input the forlder of FASTQ
> FASTQ file should like this: rHG011_1.fq.gz rHG011_2.fq.gz

$ FQ.demo

>select config file

PRE03_config.sh

## rDD-PIPE started when you see  a new file named: 

> FQ.demo.PRE03_config.sh.20220602-021820.START...
```

## 7. Check executing status

```{bash eval=FALSE, include=TRUE}
# rDD-PIPE running log is recorded in this log file in realtime

>FQ.demo.PRE03_config.sh.20220602-021820.log

$ less FQ.demo.PRE03_config.sh.20220602-021820.log
"""
sh RDD01_run_script.sh FQ.demo PRE03_config.sh FQ.demo.log 2>&1 &
FQ.demo
PRE03_config.sh
GM12878_rDD_v-snoRNA1_rep3_BR
#!/bin/bash
LIB=GM12878_rDD_v-snoRNA1_rep3_BR
NTHREAD=14
MEM=32g
datadir=/mnt/hgfs/script/rDDPP/GM12878_rDD_v-snoRNA1_rep3_BR
mainprog=/mnt/hgfs/script/rDDPP/rDD-PIPE/util/cpu-dir/cpu
JUICER=/mnt/hgfs/script/rDDPP/rDD-PIPE/util/juicer_tools.1.7.5_linux_x64_jcuda.0.8.jar
LINKER=LR
fasta=/mnt/hgfs/script/rDDPP/rDD-PIPE/ref_genome/hg38B/hg38B.fa
genome=/mnt/hgfs/script/rDDPP/rDD-PIPE/genome_size/hg38B.fa.size
SPLT=Y
bash ./10.filter_linker.pipe.sh
Linker detection on:  GM12878_rDD_v-snoRNA1_rep3_BR_1.fq.gz and 
                        GM12878_rDD_v-snoRNA1_rep3_BR_2.fq.gz
LINKER=LR
bash ./22.map_single_linker_2tags.pipe.sh
Thu 02 Jun 2022 02:23:30 AM PDT STARTED GM12878_rDD_v-snoRNA1_rep3_BR cpu memaln ..
Thu 02 Jun 2022 02:23:30 AM PDT Mapping paired tags ..
......
"""
```

## 8. Results description

Following files are main results of a rDD library:
```{bash eval=FALSE, include=TRUE}
"""
GM12878_rDD_v-snoRNA1_rep3_BR.cluster 
                         ## is the chromatin interaction cluster (loop) file
GM12878_rDD_v-snoRNA1_rep3_BR.for.BROWSER.bedgraph 
                         ## is the signal coverage file
GM12878_rDD_v-snoRNA1_rep3_BR.hic 
                         ## is the file for  2D heatmap to display in Juicerbox
GM12878_rDD_v-snoRNA1_rep3_BR.no_input_all_peaks.narrowPeak 
                         ## is the peak called by macs2

BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.HH.cluster 
                         ## is the contacts between Host-Host
BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.EE.cluster 
                         ## is the contacts between EBV-EBV
BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.HE-E.anchor 
                          ## is the EBV side anchor of the contacts between Host-EBV
BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.HE-H.anchor 
                         ## is the Host side anchor of  the contacts between Host-EBV
BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.H.bdg 
                         ## is the signal coverage of Host genome
BASIC.DIR/GM12878_rDD_v-snoRNA1_rep3_BR.HG38B.E.bdg 
                         ## is the signal coverage of EBV genome
"""
```
## 9. Data vasualization

![image](https://user-images.githubusercontent.com/88769457/179134815-f19bedfa-e9f0-48aa-9d26-2447a1f88c0a.png)


## 10. Quality control Table

GM12878_rDD_v-snoRNA1_rep3_BR.final_stats.tsv

![image](https://user-images.githubusercontent.com/88769457/179134866-5584f0c0-da30-4bbe-9397-32b817e37400.png)


## 11. Quality control Plots
![image](https://user-images.githubusercontent.com/88769457/179134913-23180f2a-5067-4a1a-8f30-2763ab2fc485.png)



