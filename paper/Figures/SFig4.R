library(ggpubr)
library(dplyr)
library(data.table)

#### read data ####
load("Beta.RData")

#### plot ####

p <- ggplot(beta, aes(x=Group, y=value, group=Group)) + geom_boxplot(aes(color=Group),outlier.shape = NA) +
  theme_classic(base_size=10) + ylab("Median Sq Error") + xlab("Method") + 
  theme(legend.position="none",axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))   + ylim(0.5,0.7)

ggsave(p, filename = "Beta.png",dpi=500)

#### median of the MEDSE ####
b2 <- beta %>% group_by(Method) %>% summarise(med = mean(value))