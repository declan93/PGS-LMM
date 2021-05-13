library(ggpubr)
library(dplyr)

#### read data ####
load("SFig2.RData")


#### pplot ####
med_dat <- dat %>% group_by(x3,x6) %>% summarise(med = median(x4))
p <- ggplot(dat, aes(x=x3, y=x5, group=x3)) + geom_boxplot(aes(color=x3),outlier.shape = NA) +theme_classic(base_size=10) + 
  ylab("Proportion") + xlab("Method") + theme(legend.position="none") + ylim(0.25,0.4) + 
  geom_hline(data= med_dat, aes( yintercept=med, col=x3),linetype="dotted" ) + facet_grid(.~x6)

ggsave("CC_prop.png", p, dpi=500)