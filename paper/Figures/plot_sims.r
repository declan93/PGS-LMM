
library(ggplot2)
library(ggpubr)
library(gridExtra)


d <- read.table("figure_Nsims.txt",h=T)
p1 <- ggplot(data = d, aes(x=N, y=p)) + 
  geom_point(aes(color=method)) +
  geom_line(aes(colour=method)) + theme_classic() +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + 
  ylab("Prop causal variants recovered")+ xlab("Sample Size")

#Variable number of causal loci

d2 <- read.table("figure_num_casual.txt",h=T)
p2 <- ggplot(data = d2, aes(x=N, y=p)) + geom_point(aes(color=method)) +
  geom_line(aes(colour=method)) + 
  theme_classic(base_size = 10) +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + 
  ylab("Prop causal variants recovered") + 
  xlab("Number causal variants recovered")

#Variable h2

d3 <- read.table("figure_sim_h2.txt",h=T)
p3 <- ggplot(data = d3, aes(x=h2, y=p)) + 
  geom_point(aes(color=method)) +geom_line(aes(colour=method)) + 
  theme_classic(base_size = 10) +
  geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) +
  ylab("Prop causal variants recovered")

p4 <- ggarrange(p3,p2, nrow = 2,labels=c("A","B"),font.label = list(size = 10, color = "black", face ="bold", family = NULL))
ggsave(p4,filename ="fig_3_rev.png",dpi = 350)

ggsave(p1, filename = "fig_4_rev.png",dpi=350)


### Fig2 

d_b = read.table("d_bolt",h=T)
d_b$colour = factor(d_b$colour)
str = paste("\U0394","Sensitivity")
pr1 <- ggplot(d_b,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  #  ylab(str) +
  ylab("") + xlab("")
#xlab("Specificity")



d_f = read.table("d_boltVfastgwaPGS",h=T)
d_f$colour = factor(d_f$colour)
str = paste("\U0394","Sensitivity")
pr2 <- ggplot(d_f,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str) +
  ylab("") + xlab("")
#  xlab("Specificity")


d = read.table("d_fastgwaVfastgwaPGS",h=T)
d$colour = factor(d$colour)
str = paste("\U0394","Sensitivity")
pr3 <- ggplot(d,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str) +
  ylab("") + xlab("")

panel_fig2 <- annotate_figure(ggarrange(pr3,pr1, nrow = 2,labels=c("A","B")),left=text_grob("\U0394 Sensitivity", color = "black", rot = 90,hjust = .2),bottom=text_grob("Specificity",hjust = 0.2))

ggsave(pr2, filename = "dROC_PGS_LMM_VS_BOLT.png",dpi=350)


## fig1a 
read.table("fig1a.txt",h=T)
p_arr <- ggplot(d, aes(x=fastGWA/1000, y=`fastGWA-PGS`/1000))+ geom_point() +geom_abline() +
geom_hline(yintercept=median(d$"fastGWA-PGS"/1000), linetype="dotted", color="#7CAE00", size=1) +ylim(.4,.55) + xlim(.4,.48) + 
geom_hline(yintercept=median(d$fastGWA/1000), linetype="dotted", color="grey", size=1) + xlab("fastGWA")  + ylab("fastGWA-PGS") + 
theme_classic()

## fig1b 
read.table("fig1b.txt",h=T)
p <- ggplot(c1, aes(x=variable, y=value/1000, colour=variable)) + geom_boxplot(outlier.shape=NA) + xlab("Method") + 
ylab("Proportion of causal variants")+ theme(legend.position = "none") +
geom_hline(yintercept=median(c1[c1$variable=="fastGWA",2]/1000), linetype="dotted", color="#00BFC4") +
geom_hline(yintercept=median(c1[c1$variable=="Bolt-PGS",2]/1000), linetype="dotted", color="#7CAE00") +
geom_hline(yintercept=median(c1[c1$variable=="Bolt",2]/1000), linetype="dotted", color="#F8766D") + 
geom_hline(yintercept=median(c1[c1$variable=="fastGWA-PGS",2]/1000), linetype="dotted", color="#C77CFF") + theme_classic() + 
theme(legend.position="none") + ylim(0.4,0.6)

fig1 <- ggarrange(p_arr,p,nrow=2,labels=c("A","B"))
ggsave("fig.png",fig1,dpi=350)
