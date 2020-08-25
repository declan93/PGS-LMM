library(ggplot2)
library(dplyr)
library(ggpubr)
library(gridExtra)
library(venn)
library(data.table)
library(scattermore)
setwd("/home/declan/work/PRSWAS/Revision/Data/")

## fig1a 
load("figure1.rda")

p_arr <- ggplot(d, aes(x=fastGWA/1000, y=`fastGWA-PGS`/1000))+ geom_point() +geom_abline() +
  geom_hline(yintercept=median(d$"fastGWA-PGS"/1000), linetype="dotted", color="#7CAE00", size=1) +ylim(.4,.55) + xlim(.4,.48) + 
  geom_hline(yintercept=median(d$fastGWA/1000), linetype="dotted", color="grey", size=1) + xlab("fastGWA")  + ylab("fastGWA-PGS") + 
  theme_classic(base_size = 8)

## fig1b removed
c1
p <- ggplot(c1, aes(x=variable, y=value/1000, colour=variable)) + geom_boxplot(outlier.shape=NA) + xlab("Method") +
  ylab("Proportion of causal variants")+ theme(legend.position = "none") +
  geom_hline(yintercept=median(c1[c1$variable=="fastGWA",2]/1000), linetype="dotted", color="#00BFC4") +
  geom_hline(yintercept=median(c1[c1$variable=="Bolt-LMM-PGS",2]/1000), linetype="dotted", color="#7CAE00") +
  geom_hline(yintercept=median(c1[c1$variable=="Bolt-LMM",2]/1000), linetype="dotted", color="#F8766D") +
  geom_hline(yintercept=median(c1[c1$variable=="fastGWA-PGS",2]/1000), linetype="dotted", color="#C77CFF") + theme_classic(base_size = 8) +
  theme(legend.position="none") + ylim(0.4,0.6)


ggsave(p_arr, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/Fig1.png",dpi=500)

### Fig2  & SFig1

d_b = read.table("d_bolt2",h=T)
d_b$colour = factor(d_b$colour)
str = paste("\U0394","Sensitivity")
pr1 <- ggplot(d_b,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  #  ylab(str) +
  ylab("") + xlab("")
#xlab("Specificity")



d_f = read.table("d_bolt_fastgwaPGS2",h=T)
d_f$colour = factor(d_f$colour)
str = paste("\U0394","Sensitivity")
pr2 <- ggplot(d_f,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str) +
  ylab("") + xlab("")
#  xlab("Specificity")


d = read.table("d_fastgwa2",h=T)
d$colour = factor(d$colour)
str = paste("\U0394","Sensitivity")
pr3 <- ggplot(d,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str) +
  ylab("") + xlab("")

fig2 <- annotate_figure(ggarrange(pr3,pr1, nrow = 2,labels=c("A","B")),left=text_grob("\U0394 Sensitivity", color = "black", rot = 90,hjust = .2,size=12),bottom=text_grob("Specificity",hjust = 0.2,size=12))
ggsave(fig2, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/Fig2.png",dpi=500)
ggsave(pr2, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/suppFig1.png",dpi=500)

# Fig3/4

d <- read.table("figure_Nsims.txt",h=T)

fig4 <- ggplot(data = d, aes(x=N, y=p)) + 
  geom_point(aes(color=method),size=0.2) +
  geom_line(aes(colour=method)) + theme_classic() + theme(legend.text = element_text(size = 10)) +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + 
  ylab("Prop causal variants recovered")+ xlab("Sample Size")

#Variable number of causal loci

d2 <- read.table("figure_num_casual.txt",h=T)
p2 <- ggplot(data = d2, aes(x=N, y=p)) + geom_point(aes(color=method),size=0.2) +
  geom_line(aes(colour=method)) + 
  theme_classic() + theme(legend.text = element_text(size = 10)) +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + 
  ylab("") + 
  xlab("Number causal variants")

#Variable h2

d3 <- read.table("figure_sim_h2.txt",h=T)
p3 <- ggplot(data = d3, aes(x=h2, y=p)) + 
  geom_point(aes(color=method),size=0.2) +geom_line(aes(colour=method)) + 
  theme_classic() + theme(legend.text = element_text(size = 10)) +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) +
  ylab("")

fig3 <- annotate_figure(ggarrange(p3,p2, nrow = 2,labels=c("A","B"),font.label = list(size = 8, color = "black", face ="bold", family = NULL)), left=text_grob("Prop causal variants recovered", size=12, color = "black", rot = 90,hjust = .45))

ggsave(fig3,filename ="/home/declan/Latex/PGS_LMM/nat_comms/images/Fig3.png",dpi = 500)

ggsave(fig4, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/Fig4.png",dpi=500)



## prediction plots Fig5 & Sfig6
sb80 <- read.table("sb80_fig.txt",h=T)
sb20 <- read.table("sb20_fig.txt",h=T)
prs20 <- read.table("prs20_fig.txt",h=T)
prs80 <- read.table("prs80_fig.txt",h=T)

s80 <- ggplot(data=sb80,aes(x=PIP, y=R2, col=Method)) + geom_line() +geom_point() +
  xlab("Posterior inclusion probability threshold") + 
  ylim(0,.2) + ylab("R2") +  
  geom_errorbar(aes(ymin=R2-(2*SE), ymax=R2+(2*SE)), width=.02) + theme(legend.text = element_text(size = 10)) +theme_classic2()

s20 <- ggplot(data=sb20,aes(x=PIP, y=R2, col=Method)) + geom_line() +
  geom_point() +xlab("Posterior inclusion probability threshold") + 
  ylim(0,.15) + ylab("R2") +  
  geom_errorbar(aes(ymin=R2-(2*SE), ymax=R2+(2*SE)), width=.02) + 
  theme(legend.text = element_text(size = 10)) +theme_classic2()

p20 <- ggplot(data=prs20, aes(x=Threshold, y=R2, col=Set)) + 
  geom_line() +geom_point() + 
  xlab("P-Value threshold") + ylim(0,.15) + 
  geom_errorbar(aes(ymin=R2-(2*se), ymax=R2+(2*se)), width=.02)+ labs(color = "Method") + 
  theme(legend.text = element_text(size = 10)) +theme_classic2()

p80 <- ggplot(data=prs80, aes(x=Threshold, y=R2, col=Set)) + geom_line() +
  geom_point() + 
  xlab("P-Value threshold") + ylim(0,.2) + 
  geom_errorbar(aes(ymin=R2-(2*se), ymax=R2+(2*se)), width=.02)+ 
  labs(color = "Method") +theme(legend.text = element_text(size = 10)) +theme_classic2()

fig5 <- ggarrange(p80,s80,nrow=2,labels=c("A","B"))
panel_20 <- ggarrange(p20,s20,nrow=2,labels=c("A","B"))

ggsave(fig5, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/Fig5.png",dpi=500)
ggsave(panel_20, filename = "/home/declan/Latex/PGS_LMM/nat_comms/images/suppFig6.png",dpi=500)



## sup fig 2 Data too large to host on github

#st <- read.table("sup_fig_pval_comp.txt", h=T)
#colnames(st) <- c("fastGWA-PGS","fastGWA")
#sfig1 <- ggplot(st) + geom_scattermore(aes(x=fastGWA, y=`fastGWA-PGS`)) + 
#  geom_abline(intercept = 0, slope = 1) + 
#  xlab("-log10 fastGWA p-values") + ylab("-log10 fastGWA-PGS p-values") + 
#  theme_classic()
#ggsave(sfig1, filename="/home/declan/Latex/PGS_LMM/nat_comms/images/suppFig2.png", dpi=500)

# SFig3

load("v_list.rda")
png("/home/declan/Latex/PGS_LMM/nat_comms/images/suppFig3.png")
venn(v_list,zcolor="style", snames=c("fastGWA","fastGWA-PGS"),box=F)
dev.off()

## supp Fig4

f3 <- read.table("sf4.txt", h=T)
sfig3 <- f3 %>% na.omit() %>% group_by(group, bin) %>% summarise(n = n()) %>% 
  group_by(group) %>% mutate(y = n/sum(n)) %>% ggplot()+ 
  geom_col(aes(y=y, x = bin, fill = as.factor(group)), position="dodge") + 
  scale_y_continuous(labels=scales::percent_format()) + xlab("Allele frequency bins") + 
  ylab("Percentage variants") + 
  labs(fill="Significance set") + scale_x_discrete(labels=c("<1%","1-5%","5-10%","10-20%","20-50%")) + 
  theme(legend.position = c(0.099, 0.82),legend.text = element_text(size = 10)) + theme_classic2()

ggsave(sfig3, filename="/home/declan/Latex/PGS_LMM/nat_comms/images/suppFig4.png", dpi=500)

#Sfig7 
load("figureS7.rda")
p1 <- ggplot(sim, aes(x=Effect)) + geom_histogram(aes(y=..density..),bins=20, colour="black", fill="white") + theme_classic() + xlab("Simulated effect size") + geom_density(alpha=.2, fill="blue")

p2 <- ggplot(phen, aes(x=V3)) + geom_histogram(aes(y=..density..),bins=20,colour="black", fill="white") + theme_classic() + xlab("Simulated phenotye distribution") + geom_density(alpha=.2, fill="blue")
p_out <- ggarrange(p1,p2, labels=c("A","B"))
ggsave("suppFig7.png",p_out,dpi=500)
