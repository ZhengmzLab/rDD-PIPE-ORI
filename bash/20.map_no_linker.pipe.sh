
tagname="none"

export LOGFILE=${LIB}.2.map_none.log

mapquality=30

# -- perform hybrid bwa men and bwa all mapping, de-duplication, span computation, and tag clustering --
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
$mainprog span -g -t ${NTHREAD} ${LIB}.$tagname.UU.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UU.span.xls
echo `date` ENDED ${LIB} span pair .. | tee -a ${LOGFILE}

# deduplication
echo `date` De-duplicating paired tags UU .. | tee -a ${LOGFILE}
$mainprog dedup -g -t ${NTHREAD} ${LIB}.$tagname.UU.bam 1>${LIB}.$tagname.UU.dedup.lc 2>> ${LOGFILE}
rm ${LIB}.$tagname.UU.cpu.dedup 2>> ${LOGFILE}
echo `date` ENDED ${LIB} cpu dedup .. | tee -a ${LOGFILE}

# deduplicated span
echo `date` Computing span of paired tags UU nr .. | tee -a ${LOGFILE}
$mainprog span -t ${NTHREAD} ${LIB}.$tagname.UU.nr.bam 2>> ${LOGFILE} 1>${LIB}.$tagname.UU.nr.span.xls
echo `date` ENDED ${LIB} cpu dedup span.. | tee -a ${LOGFILE}


echo "$0 done" > map_no_linker.done
