
# perform linker detection and generation of different category of fastq files
echo "Linker detection on: ${LIB}_1.fq.gz and  ${LIB}_2.fq.gz" 2>${LIB}.stag.log



#  ACGCGATGGCTACTCTGACT  --ORI
#  AGTCAGAGTAGCCATCGCGT  -RC
#  TCAGTCTCATCGGTAGCGCA  -R
#  TGCGCTACCGATGAGACTGA -C

BR=LINKER2021APR2501="ACGCGATGGCTACTCTGACT"
LR=LINKER2021MAY2301="ACGCGATATCTTATCTGACT"


if [ $LINKER = "BR" ] ## default Bridge linker of ChIA-PET
then
	echo "LINKER=BR"
	$mainprog stag -W -T 18 -t ${NTHREAD} -O ${LIB} $datadir/${LIB}_1.fq.gz $datadir/${LIB}_2.fq.gz 2>${LIB}.stag.log
fi	

if [ $LINKER = "LR" ] ## rDD used Longreads Linker
then
	echo "LINKER=LR"
	$mainprog stag -A ACGCGATGGCTACTCTGACT -W -T 18 -t ${NTHREAD} -O ${LIB} $datadir/${LIB}_1.fq.gz $datadir/${LIB}_2.fq.gz 2>${LIB}.stag.log
fi
##$mainprog stag -A ACGCGATGGCTACTCTGACT -W -T 18 -t ${NTHREAD} -O ${LIB} $datadir/${LIB}_1.fq.gz $datadir/${LIB}_2.fq.gz 2>${LIB}.stag.log
##$mainprog stag -W -T 18 -t ${NTHREAD} -O ${LIB} $datadir/${LIB}_1.fq.gz $datadir/${LIB}_2.fq.gz 2>${LIB}.stag.log
echo "--- linker detection completed ----" >>${LIB}.stag.log

#Get the stat
$mainprog stat -s -p -T 18 -t ${NTHREAD} ${LIB}.cpu 2>${LIB}.stag.log 1>${LIB}.stat
echo "--- statistics done  ----" >>${LIB}.stag.log

date >>${LIB}.stag.log

pigz -p ${NTHREAD} ${LIB}.singlelinker.paired.fastq 2>>${LIB}.stag.log
pigz -p ${NTHREAD} ${LIB}.none.fastq 2>>${LIB}.stag.log

#Uncomment the following if we want to keep the files
pigz -p ${NTHREAD} ${LIB}.singlelinker.single.fastq 2>>${LIB}.stag.log
pigz -p ${NTHREAD} ${LIB}.conflict.fastq 2>>${LIB}.stag.log
pigz -p ${NTHREAD} ${LIB}.tied.fastq 2>>${LIB}.stag.log

echo "$0 done" > linker_filtering.done
