#### libraries ####
library(data.table)
library(ggpubr)
library(parallel)
library(xtable)
library(dplyr)

#### data read ####
# format ->  x(specificty) y(delta Sensitivity) base(Sensitivity) sim(1:100) colour(grey sim red, mean)

d <- fread("fastGWA_ldpred2.txt",h=T)
d1 = fread("bolt665_ldpred2.txt",h=T)
d2 = fread("fastgwavsregenie.txt",h=T)
d3 = fread("fastgwavsregeniepgs.txt",h=T)
d4 = fread("bolt165_boltpgs165.txt",h=T)
d5 = fread("fastGWA_BOLT665.txt",h=T)
d6 = fread("fastgwavsPT",h=T)
d7 = fread("fGWAPGS_ldpred2.txt",h=T)

#### add color factor ####
d$colour = factor(d$colour)
d1$colour = factor(d1$colour)
d2$colour = factor(d2$colour)
d3$colour = factor(d3$colour)
d4$colour = factor(d4$colour)
d5$colour = factor(d5$colour)
d6$colour = factor(d6$colour)
d7$colour = factor(d7$colour)
str = paste("\U0394","Sensitivity")

#### plot ####

fGWA_ldpred2 <- ggplot(d,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  #ylab(str)+ xlab("Specificity") 
  ylab("")+ xlab("")
fGWAldpred2_bolt665 <- ggplot(d1,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")

fGWA_regenie <- ggplot(d2,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")

fGWA_regeniePGS <- ggplot(d3,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")

bolt165_pgs <- ggplot(d4,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")

fGWA_bolt665 <- ggplot(d5,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0) +
  ylab("") + xlab("")
#  ylab(str)+ xlab("Specificity")

fGWA_PT <- ggplot(d6,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")

fGWApgs_LDpred2 <- ggplot(d7,aes(x=x,y=y,colour=colour)) + theme_classic(base_size=10)+ scale_color_manual(values=c("grey","red")) +
  theme(legend.position = "none", panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(aes(group=sim)) + xlim(1,0) + geom_hline(yintercept = 0)+
  ylab(str)+ xlab("Specificity")


fig2 <- annotate_figure(ggarrange(fGWA_ldpred2,fGWA_bolt665, nrow = 2,labels=c("A","B")),
                        left=text_grob("\U0394 Sensitivity", color = "black", 
                                       rot = 90,hjust = .2,size=12),
                        bottom=text_grob("Specificity",hjust = 0.2,size=12))

ggsave("fig2.png",fig2,dpi=500)
ggsave("fig2_fGWA_ldpred2.png",fGWA_ldpred2,dpi=500)
ggsave("fig2_fGWAldpred2_bolt665.png",fGWAldpred2_bolt665,dpi=500)
ggsave("fig2_fGWA_regenie.png",fGWA_regenie,dpi=500)
ggsave("fig2_fGWA_regeniePGS.png",fGWA_regeniePGS,dpi=500)
ggsave("fig2_bolt165_pgs.png",bolt165_pgs,dpi=500)
ggsave("fig2_fGWA_bolt665.png",fGWA_bolt665,dpi=500)
ggsave("fig2_fGWA_PT.png",fGWA_PT,dpi=500)

#### sensitivity at max dSpecifity ####
mx_fgw_ldp <- d[d$y==max(d[d$colour==1,"y"]),1:2]
mx_blt665_ldp <- d1[d1$y==max(d1[d1$colour==1,"y"]),1:2]
mx_fgwa_regenie <- d2[d2$y==max(d2[d2$colour==1,"y"]),1:2]
mx_fgwa_regenie_pgs <- d3[d3$y==max(d3[d3$colour==1,"y"]),1:2]
mx_blt165_boltPGS <- d4[d4$y==max(d4[d4$colour==1,"y"]),1:2]
mx_fgw_blt665 <- d5[d5$y==max(d5[d5$colour==1,"y"]),1:2]
mx_fgw_PT <- d6[d6$y==max(d6[d6$colour==1,"y"]),1:2]
mx_fgwPT_ldp <- d7[d7$y==max(d7[d7$colour==1,"y"]),1:2]

#### Rel increases #### 
rel_fgw_ldp <- (d[d$y==max(d[d$colour==1,"y"]),2] + d[d$y==max(d[d$colour==1,"y"]),3])/d[d$y==max(d[d$colour==1,"y"]),3] -1
rel_blt665_ldp <- (d1[d1$y==max(d1[d1$colour==1,"y"]),2] + d1[d1$y==max(d1[d1$colour==1,"y"]),3])/d1[d1$y==max(d1[d1$colour==1,"y"]),3] -1
rel_fgwa_regenie <- (d2[d2$y==max(d2[d2$colour==1,"y"]),2] + d2[d2$y==max(d2[d2$colour==1,"y"]),3])/d2[d2$y==max(d2[d2$colour==1,"y"]),3] -1
rel_fgwa_regenie_pgs <- (d3[d3$y==max(d3[d3$colour==1,"y"]),2] + d3[d3$y==max(d3[d3$colour==1,"y"]),3])/d3[d3$y==max(d3[d3$colour==1,"y"]),3] -1
rel_blt165_boltPGS <- (d4[d4$y==max(d4[d4$colour==1,"y"]),2] + d4[d4$y==max(d4[d4$colour==1,"y"]),3])/d4[d4$y==max(d4[d4$colour==1,"y"]),3] -1
rel_fgw_blt665 <- (d5[d5$y==max(d5[d5$colour==1,"y"]),2] + d5[d5$y==max(d5[d5$colour==1,"y"]),3])/d5[d5$y==max(d5[d5$colour==1,"y"]),3] -1
rel_fgw_PT <- (d6[d6$y==max(d6[d6$colour==1,"y"]),2] + d6[d6$y==max(d6[d6$colour==1,"y"]),3])/d6[d6$y==max(d6[d6$colour==1,"y"]),3] -1
rel_fgwPT_ldp <- (d7[d7$y==max(d7[d7$colour==1,"y"]),2] + d7[d7$y==max(d7[d7$colour==1,"y"]),3])/d7[d7$y==max(d7[d7$colour==1,"y"]),3] -1


#### tabulate ####
names_M <- c("fastGWAvfastGWA-PGS-LDpred2","BOLT-LMM-665vfastGWA-PGS-LDPred2","fastGWAvREGENIE",
             "fastGWAvREGENIE-PGS-PT","BOLT-LMM-165vBOLT-LMM-PGS-PT","fastGWAvBOLT-LMM-665",
             "fastGWAvfastGWA-PGS-PT","fastGWA-PGS-PTvfastGWA-PGS-LDpred2")
fig2_dat <- data.frame("Method"=names_M,
           "rel_increase"= c(rel_fgw_ldp$y,rel_blt665_ldp$y, rel_fgwa_regenie$y, rel_fgwa_regenie_pgs$y, rel_blt165_boltPGS$y, 
                    rel_fgw_blt665$y, rel_fgw_PT$y, rel_fgwPT_ldp$y),
           "max_dSensitivity"=c(mx_fgw_ldp$y, mx_blt665_ldp$y, mx_fgwa_regenie$y, 
                   mx_fgwa_regenie_pgs$y, mx_blt165_boltPGS$y, mx_fgw_blt665$y, mx_fgw_PT$y, mx_fgwPT_ldp$y),
           "max_specificty"=c(mx_fgw_ldp$x, mx_blt665_ldp$x, mx_fgwa_regenie$x, 
                             mx_fgwa_regenie_pgs$x, mx_blt165_boltPGS$x, mx_fgw_blt665$x, mx_fgw_PT$x, mx_fgwPT_ldp$x) )
fig2_dat %>% xtable(display=c("s","s","f","f","f"), digits=4)

