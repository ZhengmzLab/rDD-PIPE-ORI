


tagname="singlelinker.paired"
export LOGFILE=${LIB}.2.map_$tagname.log

#--------------------------------------------------------
#PARAMETERS
selfbp=8000 #self ligation in bp
mapquality=30 #mapping quality cutoff
extbp=500 #extension size from each ends in clustering PETs

#-- perform hybrid bwa men and bwa all mapping, de-duplication, span computation, and tag clustering --#
# mapping
echo `date` STARTED ${LIB} cpu memaln .. | tee -a ${LOGFILE}
echo `date` Mapping paired tags .. | tee -a ${LOGFILE}
$mainprog memaln -T ${mapquality} -t ${NTHREAD} $fasta ${LIB}.$tagname.fastq.gz 2>> ${LOGFILE} 1>${LIB}.$tagname.sam
pigz -p 4 ${LIB}.$tagname.sam 2>&1  | tee -a ${LOGFILE}
echo `date` ENDED ${LIB} cpu memaln .. | tee -a ${LOGFILE}

# pairing -s INT bp self ligation flag
echo `date` STARTED ${LIB} cpu pair .. | tee -a ${LOGFILE}
$mainprog pair -S -s $selfbp -q $mapquality -t ${NTHREAD} ${LIB}.$tagname.sam.gz 1>${LIB}.$tagname.stat.xls 2>> ${LOGFILE}
echo `date` ENDED ${LIB} cpu pair .. | tee -a ${LOGFILE}

# span
echo `date` Computing span of paired tags .. | tee -a ${LOGFILE}
$mainprog span -g -s $selfbp -t ${NTHREAD} ${LIB}.$tagname.UU.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UU.span.xls
echo `date` ENDED ${LIB} span pair .. | tee -a ${LOGFILE}

# deduplication
echo `date` De-duplicating paired tags UU .. | tee -a ${LOGFILE}
$mainprog dedup -g -s $selfbp -t ${NTHREAD} ${LIB}.$tagname.UU.bam 1>${LIB}.$tagname.UU.dedup.lc 2>> ${LOGFILE}
rm ${LIB}.$tagname.UU.cpu.dedup 2>> ${LOGFILE}
echo `date` ENDED ${LIB} cpu dedup .. | tee -a ${LOGFILE}

# deduplicated span
echo `date` Computing span of paired tags UU nr .. | tee -a ${LOGFILE}
$mainprog span -s $selfbp -t ${NTHREAD} ${LIB}.$tagname.UU.nr.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UU.nr.span.xls
echo `date` ENDED ${LIB} cpu dedup span.. | tee -a ${LOGFILE}

# cluster tags, extent 500bp
echo `date` STARTED ${LIB} cpu clustering with extension $extbp bp from each sides | tee -a ${LOGFILE}
$mainprog cluster -m -s $selfbp -B 1000 -5 5,0 -3 3,${extbp} -t ${NTHREAD} -j -x -v 1 -g  -O ${LIB}.e500 ${LIB}.$tagname.UU.nr.bam 2>&1 | tee -a ${LOGFILE}
rm ${LIB}.e500.cpu.cluster 2>> ${LOGFILE}
zcat *.chiasig.gz|awk '{if($7>1)print}' > ${LIB}.cluster 
echo `date` ENDED ${LIB} cpu clustering.. | tee -a ${LOGFILE}

#Generate .hic file
#java -Xmx32g -jar /mnt/hgfs/chiapipe/pipeline_development/softwares/juicer_tools_1.19.01.jar pre -r 2500000,1000000,500000,250000,100000,50000,25000,10000,5000,1000 ${LIB}.e500.juice.gz $LIB.hic $genome


java -Xmx${MEM} -jar ${JUICER} pre -r 2500000,1000000,500000,250000,100000,50000,25000,10000,5000,1000 ${LIB}.e500.juice.gz $LIB.hic $genome

echo "$0 done" > map_single_linker_2tags.done
