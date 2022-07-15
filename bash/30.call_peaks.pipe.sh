

tagname="singlelinker.paired"

LOGFILE=${LIB}.3.macs.log

tagname1="singlelinker.paired"
tagname2="singlelinker.single"


# convert to bedgraph
# sort bam for samtools counting bases and for BASIC visualization
samtools sort -@ ${NTHREAD} ${LIB}.singlelinker.paired.UU.nr.bam -o ${LIB}.singlelinker.paired.UU.nr.sorted.bam

samtools sort -@ ${NTHREAD} ${LIB}.singlelinker.single.UxxU.nr.bam -o ${LIB}.singlelinker.single.UxxU.nr.sorted.bam

samtools sort -@ ${NTHREAD} ${LIB}.none.UU.nr.bam -o ${LIB}.none.UU.nr.sorted.bam

samtools merge -f -@ ${NTHREAD} ${LIB}.for.BROWSER.bam ${LIB}.singlelinker.paired.UU.nr.sorted.bam ${LIB}.singlelinker.single.UxxU.nr.sorted.bam ${LIB}.none.UU.nr.sorted.bam

#bedtools genomecov -ibam ${LIB}.for.BROWSER.bam -bg > ${LIB}.for.BROWSER.bedgraph

macs2 callpeak --keep-dup all --nomodel -t ${LIB}.for.BROWSER.bam -f BAM -g hs -n ${LIB}.no_input_all

bedtools genomecov -ibam ${LIB}.for.BROWSER.bam -bg > ${LIB}.for.BROWSER.bedgraph
 

