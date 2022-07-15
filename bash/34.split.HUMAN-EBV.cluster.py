"""
LIB=$(pwd|rev|cut -d"/" -f1|rev)
HG=HG38
EBV=B

F=${LIB}.cluster.BE2

cat $F|awk -v lib=$LIB -v h=$HG -v e=$EBV   '{if($2=="chrB" && $4=="chrB") print > lib"."he".EE.cluster" }'

#chr18	72587612	72588262	chrB	138281	138856	3
"""
import os,sys
LIB=sys.argv[1]
HG=sys.argv[2] #HG38
EBV=sys.argv[3] #B
BDIR=sys.argv[4]
FIN=open(LIB+".cluster.BE2","r")
FOUT01=open(".".join([BDIR+"/"+LIB,HG+EBV,"HH","cluster"]),"w")
FOUT02=open(".".join([BDIR+"/"+LIB,HG+EBV,"EE","cluster"]),"w")
FOUT03=open(".".join([BDIR+"/"+LIB,HG+EBV,"HE-H","anchor"]),"w")
FOUT04=open(".".join([BDIR+"/"+LIB,HG+EBV,"HE-E","anchor"]),"w")

while True:
 line=FIN.readline()
 if not line:
  break
 word=line.rstrip("\n").split("\t")
 C1=word[0]
 S1=int(word[1])
 E1=int(word[2])
 C2=word[3]
 S2=int(word[4])
 E2=int(word[5])
 PET=int(word[6])
 EC="chr"+EBV
 if C1==EC and C2==EC: 
  FOUT02.write(line)
 elif C1 != EC and C2 != EC:
  FOUT01.write(line)
 elif C1 != EC and C2 == EC:
  FOUT03.write(line)
  FOUT04.write("\t".join([C2,str(S2),str(E2),C1,str(S1),str(E1),str(PET),"\n"]))
 elif C1 == EC and C2 != EC:
  FOUT04.write(line)
  FOUT03.write("\t".join([C2,str(S2),str(E2),C1,str(S1),str(E1),str(PET),"\n"]))




