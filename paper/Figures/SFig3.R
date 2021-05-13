library(ggpubr)

#### read data ####
load("BOLTPGS.RData")

p <- ggplot(d, aes(x=Method, y=Proportion, colour=Method)) + geom_boxplot(outlier.shape=NA) + xlab("Method") + geom_hline(yintercept=median(d[d$Method=="BOLT-LMM-665-PGS-PT","Proportion"]), linetype="dotted", color="#00BFC4") + geom_hline(yintercept=median(d[d$Method=="BOLT-LMM-665","Proportion"]), linetype="dotted", color="#F8766D") + theme_classic() + ylim(0.4,0.6)
ggsave("BOLT65PGS.png", p, dpi=500)
