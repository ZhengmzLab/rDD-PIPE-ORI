#install.packages("ggplot2")
#library(ggplot2)
#if (!require("")) install.packages("", repos = "http://cran.us.r-project.org")
#if (!require("")) install.packages("", repos = "http://cran.us.r-project.org")
#if (!require("")) install.packages("", repos = "http://cran.us.r-project.org")
#if (!require("")) install.packages("", repos = "http://cran.us.r-project.org")
if (!require("readr")) install.packages("readr", repos = "http://cran.us.r-project.org")
if (!require("dplyr")) install.packages("dplyr", repos = "http://cran.us.r-project.org")
if (!require("readr")) install.packages("readr", repos = "http://cran.us.r-project.org")
if (!require("ggplot2")) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if (!require("gridExtra")) install.packages("gridExtra", repos = "http://cran.us.r-project.org")
if (!require("dplyr")) install.packages("dplyr", repos = "http://cran.us.r-project.org")
if (!require("sitools")) install.packages("sitools", repos = "http://cran.us.r-project.org")
if (!require("viridis")) install.packages("viridis", repos = "http://cran.us.r-project.org")
if (!require("RColorBrewer")) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if (!require("colorRamps")) install.packages("colorRamps", repos = "http://cran.us.r-project.org")
if (!require("scales")) install.packages("scales", repos = "http://cran.us.r-project.org")



if (!require("ggplot2")) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if (!require("gridExtra")) install.packages("gridExtra", repos = "http://cran.us.r-project.org")
args = commandArgs(trailingOnly=TRUE)
LIB=args[1]
#setwd("/Users/zhongyuantian/macshare/workSpace2021B/script/rDDPP/GM12878_rDD_v-snoRNA1_rep3_BR/")
IN=paste0(LIB,".final_stats.tsv")
#IN="GM12878_rDD_v-snoRNA1_rep3_BR.final_stats.tsv"
FIN=read.table(IN)
FIN$LN=row.names(FIN)
colnames(FIN)<-c("item","value","line_id")
print((FIN))
DF00=FIN
Total_read_pairs = parse_number(paste(FIN[3,2],collapse=NULL))
Read_pairs_with_linker = parse_number(paste(FIN[4,2],collapse=NULL))
Fraction_read_pairs_with_linker = parse_number(paste(FIN[5,2],collapse=NULL))
One_tag = parse_number(paste(FIN[6,2],collapse=NULL))
PET = parse_number(paste(FIN[7,2],collapse=NULL))
Uniquely_mapped_PET = parse_number(paste(FIN[8,2],collapse=NULL))
Non_redundant_PET = parse_number(paste(FIN[9,2],collapse=NULL))
Redundancy = parse_number(paste(FIN[10,2],collapse=NULL))
Non_redundant_tag = parse_number(paste(FIN[11,2],collapse=NULL))
Peak = parse_number(paste(FIN[12,2],collapse=NULL))
Self_ligation_PET = parse_number(paste(FIN[13,2],collapse=NULL))
Inter_ligation_PET = parse_number(paste(FIN[14,2],collapse=NULL))
Intra_chr_PET = parse_number(paste(FIN[15,2],collapse=NULL))
Inter_chr_PET = parse_number(paste(FIN[16,2],collapse=NULL))
ratio_of_intra_inter_PET = parse_number(paste(FIN[17,2],collapse=NULL))
Singleton = parse_number(paste(FIN[18,2],collapse=NULL))
Intra_chr_singleton = parse_number(paste(FIN[19,2],collapse=NULL))
Inter_chr_singleton = parse_number(paste(FIN[20,2],collapse=NULL))

PET_4loop=Inter_ligation_PET-Singleton
PET_4loop
PET_cluster = parse_number(paste(FIN[21,2],collapse=NULL))
ratio_of_intra_inter_cluster = parse_number(paste(FIN[22,2],collapse=NULL))
Intra_chr_PET_cluster = parse_number(paste(FIN[23,2],collapse=NULL))
Inter_chr_PET_cluster = parse_number(paste(FIN[34,2],collapse=NULL))
Host_Host_Loops = parse_number(paste(FIN[45,2],collapse=NULL))
EBV_EBV_Loops = parse_number(paste(FIN[46,2],collapse=NULL))
Host_EBV_Loops = parse_number(paste(FIN[47,2],collapse=NULL))

HE_EE_loops=EBV_EBV_Loops+Host_EBV_Loops

read_4PET=PET/Read_pairs_with_linker
read_4OneTag=One_tag/Read_pairs_with_linker
read_4NoTag=(Read_pairs_with_linker-PET-One_tag)/Read_pairs_with_linker
DF01 = data.frame("item" = c("read_pairs\nwith_linker"," "),
                  "share" = c(Fraction_read_pairs_with_linker,1-Fraction_read_pairs_with_linker))
PIE01 = ggplot(DF01, aes(x="", y=share, fill=item)) + 
  geom_bar(stat="identity", width=1,color="black")+
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste0(item,"\n",round(share*100), "%"),size=item), position = position_stack(vjust = 0.5),color="white")+
  scale_fill_manual(values=c("read_pairs\nwith_linker"="#607d8b", " "="#FFFFFF"))+
  scale_size_manual(values=c("read_pairs\nwith_linker"=5, " "=0))+
  labs(x = NULL, y = NULL, fill = NULL, title = "")+
  theme_void() + 
  theme(legend.position="none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, color = "#666666"))

#PIE01

DF02 = data.frame("item" = c("ratio_of\nPET\nintra:inter"," "),
                  "share" = c(ratio_of_intra_inter_PET,1-ratio_of_intra_inter_PET))
PIE02 = ggplot(DF02, aes(x="", y=share, fill=item)) + 
  geom_bar(stat="identity", width=1,color="black")+
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste0(item,"\n",share),size=item), position = position_stack(vjust = 0.5),color="white")+
  scale_fill_manual(values=c("ratio_of\nPET\nintra:inter"="#7b1fa2", " "="#FFFFFF"))+
  scale_size_manual(values=c("ratio_of\nPET\nintra:inter"=5, " "=0))+
  
  labs(x = NULL, y = NULL, fill = NULL, title = "")+
  theme_void() + 
  theme(legend.position="none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, color = "#666666"))

#PIE02

DF03 = data.frame("item" = c("ratio_of_loop\nintra:inter"," "),
                  "share" = c(ratio_of_intra_inter_cluster,1-ratio_of_intra_inter_cluster))
PIE03 = ggplot(DF03, aes(x="", y=share, fill=item)) + 
  geom_bar(stat="identity", width=1,color="black")+
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste0(item,"\n",share),size=item), position = position_stack(vjust = 0.5),color="white")+
  scale_fill_manual(values=c("ratio_of_loop\nintra:inter"="#7b1fa2", " "="#FFFFFF"))+
  scale_size_manual(values=c("ratio_of_loop\nintra:inter"=5, " "=0))+
  
  labs(x = NULL, y = NULL, fill = NULL, title = "")+
  theme_void() + 
  theme(legend.position="none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, color = "#666666"))

#PIE03


DF04 = data.frame("item" = c("Redundancy"," "),
                  "share" = c(Redundancy,1-Redundancy))
PIE04 = ggplot(DF04, aes(x="", y=share, fill=item)) + 
  geom_bar(stat="identity", width=1,color="black")+
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste0(item,"\n",round(share*100), "%"),size=item), position = position_stack(vjust = 0.5),color="white")+
  scale_fill_manual(values=c("Redundancy"="#607d8b", " "="#FFFFFF"))+
  scale_size_manual(values=c("Redundancy"=5, " "=0))+
  
  labs(x = NULL, y = NULL, fill = NULL, title = "")+
  theme_void() + 
  theme(legend.position="none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, color = "#666666"))

#PIE04



DF05 = data.frame("item" = c("read_count\nof_PET","read_count\nof_OneTag"," "),
                  "share" = c(read_4PET,read_4OneTag,read_4NoTag))
PIE05 = ggplot(DF05, aes(x="", y=share, fill=item)) + 
  geom_bar(stat="identity", width=1,color="black")+
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste0(item,"\n",round(share*100), "%"),size=item), position = position_stack(vjust = 0.5),color="white")+
  scale_fill_manual(values=c("read_count\nof_PET"="#607d8b", "read_count\nof_OneTag"="#9e9d24", " "="#FFFFFF"))+
  scale_size_manual(values=c("read_count\nof_PET"=5, "read_count\nof_OneTag"=5," "=0))+
  labs(x = NULL, y = NULL, fill = NULL, title = "")+
  theme_void() + 
  theme(legend.position="none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, color = "#666666"))

#PIE05


library(ggplot2)
#df = data.frame("item" = c("Samsung","Huawei","Apple","Xiaomi","OPPO","Other"),
#            "share" = c(.2090,.1580,.1210,.0930,.0860,.3320))
# Create a basic bar
P1<-ggplot(DF00) + 
   # geom_segment(data=DF00,aes(x=0,xend=Total_read_pairs,y=0,yend=0),color="navy",size=10)+
  geom_rect(aes(xmin=0,xmax=Total_read_pairs,ymin=-0.9,ymax=0),fill="navy")+
  geom_text(aes(x=Total_read_pairs/2,y=-0.5,label = paste0("Total_read_pairs ",scales::comma(Total_read_pairs)," (",round(1*100), "%)")),size=4,color="white")+
#  geom_text(aes(x=Total_read_pairs/2,y=-0.5,label = paste0("Total_read_pairs: ",scales::comma(Total_read_pairs))),size=4,color="white")+
  
  geom_rect(aes(xmin=0,xmax=Read_pairs_with_linker,ymin=-1.9,ymax=-1),fill="navy")+
  geom_text(aes(x=Read_pairs_with_linker/2,y=-1.5,label = paste0("Read_pairs_with_linker ",scales::comma(Read_pairs_with_linker)," (",round(Read_pairs_with_linker / Total_read_pairs * 100), "%)")),size=4,color="white")+
 # geom_rect(aes(xmin=Read_pairs_with_linker,xmax=Total_read_pairs,ymin=-1.9,ymax=-1),fill="gray30")+
#  geom_text(aes(x=Read_pairs_with_linker+(Total_read_pairs-Read_pairs_with_linker)/2,y=-1.5,
#                label = paste0("Read_pairs\nno_linker ",round((Total_read_pairs-Read_pairs_with_linker) / Total_read_pairs * 100), "%")),size=4,color="white")+
  geom_rect(aes(xmin=0,xmax=PET,ymin=-2.9,ymax=-2),fill="navy")+
  geom_text(aes(x=PET/2,y=-2.5,label = paste0("Two_tags (PET) ",scales::comma(PET)," (",round(PET / Read_pairs_with_linker * 100), "%)")),size=4,color="white")+
  geom_rect(aes(xmin=PET,xmax=PET+One_tag,ymin=-2.9,ymax=-2),fill="#9E9D24")+
  geom_text(aes(x=PET+One_tag/2,y=-2.5,label = paste0("One_tag ",scales::comma(One_tag)," (",round(One_tag / Read_pairs_with_linker * 100), "%)")),size=4,color="white")+
  #geom_rect(aes(xmin=PET+One_tag,xmax=PET+One_tag+No_tag,ymin=-2.9,ymax=-2),fill="gray30")+
 # geom_text(aes(x=PET+One_tag+No_tag/2,y=-2.2,label = paste0("No_tags ",round( (Read_pairs_with_linker-PET-One_tag) / Read_pairs_with_linker * 100), "%")),size=4,color="white")+
  geom_rect(aes(xmin=0,xmax=Uniquely_mapped_PET,ymin=-3.9,ymax=-3),fill="navy")+
  geom_text(aes(x=Uniquely_mapped_PET/2,y=-3.5,label = paste0("Uniquely_mapped_PET ",scales::comma(Uniquely_mapped_PET)," (",round(Uniquely_mapped_PET / PET * 100), "%)")),size=4,color="white")+
  geom_rect(aes(xmin=0,xmax=Non_redundant_PET,ymin=-4.9,ymax=-4),fill="navy")+
  geom_text(aes(x=Non_redundant_PET,y=-4.5,label = paste0("Non_redundant_PET ",scales::comma(Non_redundant_PET)," (",round(Non_redundant_PET / Uniquely_mapped_PET * 100), "%)"),hjust=-0.05),size=4,color="black")+
  geom_rect(aes(xmin=0,xmax=Inter_ligation_PET,ymin=-5.9,ymax=-5),fill="navy")+
 # geom_rect(aes(xmin=Inter_ligation_PET,xmax=Inter_ligation_PET+Self_ligation_PET,ymin=-5.9,ymax=-5),fill="gray30")+
  geom_text(aes(x=Inter_ligation_PET,y=-5.5,label = paste0("Inter_ligation_PET ",scales::comma(Inter_ligation_PET)," (",round(Inter_ligation_PET / Non_redundant_PET * 100), "%)"),hjust=-0.05),size=4,color="black")+
#  geom_text(aes(x=Inter_ligation_PET+Self_ligation_PET/2,y=-5.5,label = paste0("Self_ligation\nPET ",round(Self_ligation_PET / Non_redundant_PET * 100), "%")),size=4,color="white")+
  geom_rect(aes(xmin=0,xmax=PET_4loop,ymin=-6.9,ymax=-6),fill="navy")+
 # geom_rect(aes(xmin=PET_4loop,xmax=PET_4loop+Singleton,ymin=-6.9,ymax=-6),fill="gray30")+
  geom_text(aes(x=(PET_4loop),y=-6.5,label = paste0("PET_for_cluster ",scales::comma(PET_4loop)," (",round(PET_4loop / Inter_ligation_PET * 100), "%)"),hjust=-0.05),size=4,color="black")+
 # geom_text(aes(x=PET_4loop+Singleton/2,y=-6.5,label = paste0("Singleton ",round(Singleton / (PET_cluster+Singleton) * 100), "%")),size=4,color="white")+
  

 # scale_x_log10(labels=f2si,breaks=pretty_breaks())+
  labs(x="log(read count)",y="")+
  scale_x_continuous(position = "top")+
  theme_bw()+
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
        )
#P1
P2<-ggplot(DF00) + 
  # geom_segment(data=DF00,aes(x=0,xend=Total_read_pairs,y=0,yend=0),color="navy",size=10)+
  geom_rect(aes(xmin=0,xmax=1,ymin=-0.9,ymax=0),fill="darkgreen")+
  geom_text(aes(x=1/2,y=-0.5,label = paste0("PET_cluster ",scales::comma(PET_cluster)," (",round(100), "%)")),size=4,color="white")+
  
  geom_rect(aes(xmin=0,xmax=(Intra_chr_PET_cluster/PET_cluster)/1,ymin=-1.9,ymax=-1),fill="#3e2723")+
  geom_text(aes(x=Intra_chr_PET_cluster/PET_cluster/2,y=-1.5,label = paste0("Intra_chr_cluster ",scales::comma(Intra_chr_PET_cluster)," (",round(Intra_chr_PET_cluster/PET_cluster*100), "%)"),hjust=0.5),size=4,color="white")+
  
  geom_rect(aes(xmin=Intra_chr_PET_cluster/PET_cluster,xmax=1,ymin=-1.9,ymax=-1),fill="darkred")+
  geom_text(aes(x=Intra_chr_PET_cluster/PET_cluster+Inter_chr_PET_cluster/PET_cluster/2,y=-1.5,label = paste0("Inter_chr_cluster ",scales::comma(Inter_chr_PET_cluster)," (",round(Inter_chr_PET_cluster/PET_cluster*100), "%)")),size=4,color="white")+
  
 # geom_text(aes(x=Intra_chr_PET_cluster,y=-1.5,label = paste0("intra_chr_cluster/inter_chr_cluster\nratio ",round(Inter_chr_PET_cluster/PET_cluster*100), "%")),size=4,color="white")+
  
  geom_rect(aes(xmin=0,xmax=Host_Host_Loops/PET_cluster,ymin=-2.9,ymax=-2),fill="#006064")+
  geom_text(aes(x=Host_Host_Loops/PET_cluster/2,y=-2.5,label = paste0("Host_Host_Loops ",scales::comma(Host_Host_Loops)," (",round(Host_Host_Loops/PET_cluster*100), "%)")),size=4,color="white")+
  
  geom_rect(aes(xmin=Host_Host_Loops/PET_cluster,xmax=1,ymin=-2.9,ymax=-2),fill="#4e342e")+
  geom_text(aes(x=Host_Host_Loops/PET_cluster*0.90+HE_EE_loops/PET_cluster/2,y=-2.5,label = paste0("HE&EE_loops ",scales::comma(HE_EE_loops)," (",round(HE_EE_loops/PET_cluster*100), "%)-->")),size=4,color="white")+
#  scale_x_log10(labels=f2si,breaks=pretty_breaks())+
  scale_x_continuous(position = "top")+
  
  coord_cartesian(xlim=c(0,1))+
  labs(x="loop count",y="")+
  theme_bw()+
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
  )
#P2
ION="GM12878_rDD_v-snoRNA1_rep3_BR.cluster"
#IN="GM12878_rDD_v-snoRNA1_rep3_BR.e500.clusters.cis.chiasig.gz"
FIOON=read.table(ION,header=TRUE)
colnames(FIOON)<-c("chr","start","end","chr2","start2","end2","pet")
#chr1	1398860	1399390	chr1	29026817	29027467	2
print(class(FIOON$end-FIOON$start))
FIOON<-FIOON%>%mutate(mid=start+round((end-start)/2))
FIOON<-FIOON%>%mutate(mid2=start2+round((end2-start2)/2))
FIOON<-FIOON%>%mutate(len=mid2-mid)
MFN=10
FIOON<-FIOON%>%filter(FIOON$len>0)

FIOON<-FIOON%>%mutate(pet_name=ifelse(pet<=MFN,(pet),paste0(">",MFN)))

print(unique(FIOON$pet_name))


MX=round(density(FIOON$len)$x[which.max(density(FIOON$len)$y)])
MXPOS=paste0("max(density)$x = ",MX)

FIOON$PET=factor(FIOON$pet_name,levels=c(seq(1,MFN),paste0(">",MFN)))


TITLE=paste0(IN)
#PLOTNAME_DEN=paste0(TITLE,".DEN.png")
#png(PLOTNAME_DEN, 600,400)

PLOT_DEN<-ggplot(FIOON,aes(len, color=PET,group=PET))+
  geom_density(aes(y=..scaled..),size=1,alpha=0.85)+
  theme_bw(base_size=12)+
  xlab("log10 loop span (bp)")+
  #ggtitle(IN)+
  ylab("scaled density")+
  scale_x_log10(labels=f2si,breaks=c(500,10000,100000,10000000,1000000,100000000,1000000000),limits=c(500,1000000000))+
  scale_color_manual(values = blue2green2red(11),name="PET#")+
  theme(#panel.grid = element_blank(),
    legend.position="right",
    plot.title = element_text(size = 15, face = "bold")
  )
#dev.off()
##############
#PLOTNAME_ECDF=paste0(TITLE,".ECDF.png")

#png(PLOTNAME_ECDF, 600,400)
PLOT_ECDF<-ggplot(FIOON,aes(pet))+
  stat_ecdf(geom = "step",color="navy",size=1)+
  #    stat_ecdf(data=filter(FIOON,len>1),geom = "step",color="blue",size=1)+
  #geom_density(aes(y=..count..),color="navy")+
  theme_bw(base_size=12)+
  xlab("PET#/loop")+
  
  #ggtitle(paste0(TITLE," \n ",MXPOS))+
  ylab("PET count (percentage)")+
  scale_x_continuous(breaks=seq(2.5,11.5,1),labels=c(seq(2,10,1),">10"),limits=c(1.5,12.5))+
  coord_cartesian(xlim=c(2,12))+
  scale_y_continuous(limits=c(0.7,1), labels=percent) +
  theme(#panel.grid = element_blank(),
    legend.position="none",
    plot.title = element_text(size = 15, face = "bold")
  )
#PLOT_ECDF
#dev.off()

#PLOTNAME_LOOP=paste0(TITLE,".loop.png")
#png(PLOTNAME_LOOP, 1200,400)
#grid.arrange(PLOT_ECDF,PLOT_DEN,nrow=1,top=TITLE)
PLOT_NAME=paste0(LIB,".QC.pdf")
pdf(PLOT_NAME,16,20)
#png("STA.png",1800,400)

grid.arrange(arrangeGrob(PIE04,PIE05,PIE02,PIE03,nrow=1),arrangeGrob(P1,P2,heights=c(7,3)),arrangeGrob(PLOT_ECDF,PLOT_DEN,nrow=1,widths=c(5,7)),nrow=3,heights=c(4,5,4),top=PLOT_NAME)
dev.off()
