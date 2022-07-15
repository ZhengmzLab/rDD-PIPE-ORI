echo $LIB

mkdir BASIC.DIR


 HG=HG38
 EBV=B
## splot loops
 F=${LIB}.cluster
 SC=34.split.HUMAN-EBV.cluster.py
 python $SC  $LIB  $HG  $EBV BASIC.DIR
 wait

echo "splite bedgraph"
cat ${LIB}.for.BROWSER.bedgraph|awk -v lib=$LIB  '{if($1=="chrB" || $1=="chrA")print > "BASIC.DIR/"lib".HG38B.E.bdg"; else print  > "BASIC.DIR/"lib".HG38B.H.bdg"}'
wait
cd ../

