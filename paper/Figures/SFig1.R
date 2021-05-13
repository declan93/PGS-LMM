library(ggpubr)
#### read data ####
load("SFig1.RData")

#### plot ####

p <- ggplot(tbl, aes(x=Method, y=FPR, colour=Method)) + geom_boxplot() + xlab("Method") + 
  ylab("False Positive rate")+ theme(legend.position = "none") + 
  geom_hline(yintercept=median(tbl[tbl$Method=="fastGWA",3]), linetype="dotted", color="#F8766D") + 
  geom_hline(yintercept=median(tbl[tbl$Method=="fastGWA-PGS-PT-0.05",3]), linetype="dotted", color="#00BFC4") + 
  geom_hline(yintercept=median(tbl[tbl$Method=="fastGWA-PGS-PT-0.00005",3]), linetype="dotted", color="#7CAE00")+ ylim(0.046,.057) + 
  theme_classic() + theme(axis.text.x = element_text(angle = 45,hjust=1))

ggsave("FPR.png",p, dpi=500)