## generate hg38-EBV hybrid reference genome
conda install -c bioconda bwa=0.7.17

## hg38Bmkdir /mnt/hgfs/script/rDDPP/ref_genome/hg38B
cd /mnt/hgfs/script/rDDPP/ref_genome/hg38B
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz



conda install -c bioconda seqkit
#conda install -c bioconda seqtk
conda install -c bioconda bioawk



## We have manually downloaded EBV.B958.fasta file from https://www.ncbi.nlm.nih.gov/nuccore/NC_007605.1?report=fasta
## and save as  EBV.B958.fa.gz and renamed the chromosome name to "chrB"
zcat hg38.fa.gz |seqkit grep -vrp "^chrUn"|seqkit grep -vrp "random"|seqkit grep -vrp "alt" > hg38_clean.fa
seqkit sort -N -i -2  hg38_clean.fa -o hg38_clean.fa.sorted


## We have manually downloaded EBV.B958.fasta file from https://www.ncbi.nlm.nih.gov/nuccore/NC_007605.1?report=fasta
## and save as  EBV.B958.fa.gz and renamed the chromosome name to "chrB"

zcat EBV.B958.fa.gz > EBV.B958.fa

cat hg38_clean.fa.sorted EBV.B958.fa > hg38B.fa

rm hg38.*
rm hg38_clean*
rm EBV.B958.fa

mkdir ../../genome_size/

bioawk -c fastx '{ print $name, length($seq) }' < hg38B.fa > ../../genome_size/hg38B.size

bwa index hg38B.fa
