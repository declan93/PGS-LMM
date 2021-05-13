library(ggpubr)
library()

#### read data ####

load("PRSiceUKB.RData")

#### plot ####

p <- ggplot(dat,aes(x=log(`P-value`,10),y=R2,group=Method, color=Method)) + theme_classic(base_size=16) + geom_line() + geom_point() + 
  xlab(expression(~Log["10"](P))) + ylab(expression(~R^{"2"})) + ylim(0.01,0.15) + facet_wrap(~Phenotype)

ggsave("PRSice_ht_hbmd_bmi.png",p,dpi=500,width=11,height=7)