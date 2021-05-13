library(ggpubr)
library(data.table)
library(dplyr)
#### read data ####
#format -> Sim Ncausal NcausalSig method
load("Fig1.RData")

#### plot ####
# median proportion
med_dat <- tbl %>% group_by(method) %>% summarise(med = median(NcausalSig/Ncausal))

# plot
p <- ggplot(tbl, aes(x=method, y=NcausalSig/Ncausal, group=method)) + geom_boxplot(aes(color=method),outlier.shape = NA) +
  theme_classic(base_size=10) + ylab("Proportion") + xlab("Method") + 
  theme(legend.position="none",axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  ylim(0.4,0.6) + 
  geom_hline(data= med_dat, aes( yintercept=med, col=V4),linetype="dotted" )

# save 
ggsave(p, filename = "Fig1.png",dpi=500)