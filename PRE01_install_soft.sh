
conda create --name rddpp 

conda activate rddpp

conda install git
cd /mnt/hgfs/script/rDDPP

## clone ChIA_PIPE
git clone https://github.com/TheJacksonLaboratory/ChIA-PIPE.git
###############################################################
## install packages
conda install -c bioconda pysam biopython regex macs2 pigz


## Install java/1.8
sudo apt install openjdk-8-jre-headless

## Install perl/5.26.0
conda install perl=5.26.0


sudo apt-get update
sudo apt-get install g++
sudo apt install make
sudo apt-get install libz-dev



## Install bedtools 2.26.0
conda install -c bioconda  bedtools=2.26.0



## Install samtools/1.9
conda install -c bioconda samtools=1.9 --force-reinstall

## Install R/3.6.1
 conda install R=3.6.1
 
# cd /lib/x86_64-linux-gnu/
# sudo ln -s libreadline.so.8.0 libreadline.so.6
# sudo ln -s libncurses.so.6 libncurses.so.5

