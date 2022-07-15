

WORKDIR=${PWD}


ls -d FQ*/ 
echo "please input the forlder of FASTQ"
echo  "FASTQ file should like this: rHG011_1.fq.gz rHG011_2.fq.gz"
read DFQ00
DFQ=$(ls -d $DFQ00|cut -d"/" -f1)
#echo $DFQ
echo "\n"

ls -d *config*
echo "select config file"
read CFG
#echo $CFG
echo "\n"




PIPEDIR=${WORKDIR}"/rDD-PIPE"

TIME=`date +%Y%m%d-%H%M%S`

touch $DFQ.$TIME.START...
echo "sh RDD01_run_script.sh "$DFQ" "$CFG" > "$DFQ".log 2>&1 &" >  $DFQ.$CFG.$TIME.START...
echo "sh RDD01_run_script.sh $DFQ "$CFG" > $DFQ.log 2>&1 &" >  $DFQ.$CFG.$TIME.log

nohup sh rDDPP_EXECUTING_SCRIPT.sh $DFQ $CFG >> $DFQ.$CFG.$TIME.log 2>&1 & 





