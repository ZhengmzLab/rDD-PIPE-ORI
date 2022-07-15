#!/bin/bash
.PHONY: all
all: *final_stats.tsv

# linker filtering
linker_filtering.done: *1*fq.gz *2*fq.gz
	bash ./10.filter_linker.pipe.sh

# map single linker two tags reads and call interactions
map_single_linker_2tags.done: linker_filtering.done 
	bash ./22.map_single_linker_2tags.pipe.sh

# map single linker one tag reads
map_single_linker_1tag.done: linker_filtering.done 
	bash ./21.map_single_linker_1tag.pipe.sh

# map no linker reads
map_no_linker.done: linker_filtering.done
	bash ./20.map_no_linker.pipe.sh

# call peaks
narrowPeak.done: map_single_linker_2tags.done map_single_linker_1tag.done map_no_linker.done
	bash ./30.call_peaks.pipe.sh


# split loops by genome
*split_loops: narrowPeak.done
	bash ./35.split.hg38-B.loops.pipe.sh

# summarize statistics
*final_stats.tsv: *split_loops
	bash ./40.extract_summary_stats.pipe.sh


