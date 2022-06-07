

datadir=${PWD}
WORKDIR=$(pwd|rev|cut -d"/" -f2-|rev)
CURDIR=$(pwd|rev|cut -d"/" -f1|rev)
SEQID=$(echo $CURDIR)

LIB=$(echo $CURDIR)




echo $CURDIR
echo $SEQID
echo $LIB



PIPEDIR=${WORKDIR}"/rDD-PIPE"




FC=${LIB}.cfg
echo "#!/bin/bash" > $FC
echo "LIB="${LIB} >>  $FC
echo "NTHREAD=14" >>  $FC
echo "MEM=32g" >> $FC
echo "datadir="${datadir} >>  $FC
echo "mainprog="${PIPEDIR}"/util/cpu-dir/cpu" >>  $FC
echo "JUICER="${PIPEDIR}"/util/juicer_tools.1.7.5_linux_x64_jcuda.0.8.jar" >> $FC

echo "LINKER=LR" >> $FC  ## select 1 from:  BR LR
echo "fasta="${PIPEDIR}"/ref_genome/hg38B/hg38B.fa" >>  $FC
echo "genome="${PIPEDIR}"/genome_size/hg38B.fa.size" >>  $FC
echo "SPLT=Y" >> $FC  ## split loops and coverage by species: Y=yes; N=not



cat $FC



sleep 0.2
for FP in *.pipe.sh
do
	cat $FC $FP > TMP
	sleep 0.2
	mv TMP $FP

done

rm -rf TMP


chmod 755 *.sh


