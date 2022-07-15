
tagname="singlelinker.single"

export LOGFILE=${LIB}.2.map_single.log

mapquality=30

#-- perform hybrid bwa men and bwa all mapping, de-duplication, span computation, and tag clustering --#
# mapping
echo `date` Mapping no linker tags .. | tee -a ${LOGFILE}
$mainprog memaln -T ${mapquality} -t ${NTHREAD} $fasta  ${LIB}.$tagname.fastq.gz 2>> ${LOGFILE} 1>${LIB}.$tagname.sam
pigz -p 4 ${LIB}.$tagname.sam 2>&1  | tee -a ${LOGFILE}
echo `date` ENDED ${LIB} cpu memaln .. | tee -a ${LOGFILE}

# pairing
echo `date` Pairing paired tags .. | tee -a ${LOGFILE}
$mainprog pair -S -q $mapquality -t ${NTHREAD} ${LIB}.$tagname.sam.gz 1>${LIB}.$tagname.stat.xls 2>> ${LOGFILE}
echo `date` ENDED ${LIB} cpu pair .. | tee -a ${LOGFILE}

# span
echo `date` Computing span of paired tags .. | tee -a ${LOGFILE}
$mainprog span -g -t ${NTHREAD} ${LIB}.$tagname.UxxU.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UxxU.span.xls
echo `date` ENDED ${LIB} span pair .. | tee -a ${LOGFILE}

# deduplication
echo `date` De-duplicating paired tags UxxU .. | tee -a ${LOGFILE}
$mainprog dedup -g -t ${NTHREAD} ${LIB}.$tagname.UxxU.bam 1>${LIB}.$tagname.UxxU.dedup.lc 2>> ${LOGFILE}
rm ${LIB}.$tagname.UxxU.cpu.dedup 2>> ${LOGFILE}
echo `date` ENDED ${LIB} cpu dedup .. | tee -a ${LOGFILE}

# deduplicated span
echo `date` Computing span of paired tags UxxU nr .. | tee -a ${LOGFILE}
$mainprog span -t ${NTHREAD} ${LIB}.$tagname.UxxU.nr.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UxxU.nr.span.xls
echo `date` ENDED ${LIB} cpu dedup span.. | tee -a ${LOGFILE}

echo "$0 done" > map_single_linker_1tag.done
