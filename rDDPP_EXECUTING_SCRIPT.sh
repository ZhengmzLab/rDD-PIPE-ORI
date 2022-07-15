

WORKDIR=${PWD}

PIPEDIR=${WORKDIR}"/rDD-PIPE"


DFQ=$1
echo $DFQ

CFG=$2
echo $CFG

#echo $DPP

for F in $(ls  ${WORKDIR}/$DFQ/*_1.fq.gz)
do
	NAME=$(ls $F|rev|cut -d"/" -f1|cut -d"_" -f2-|rev)
	echo $NAME
	rm -rf $NAME
	mkdir $NAME

	cd $NAME
		ln -s ${WORKDIR}/$DFQ/${NAME}_1.fq.gz ${NAME}_1.fq.gz
		ln -s ${WORKDIR}/$DFQ/${NAME}_2.fq.gz ${NAME}_2.fq.gz
		cp $PIPEDIR/bash/* .
		sh ${WORKDIR}/${CFG}
		wait
		sh 01.runpipe.sh
		ls -lrt
	cd ../


done


