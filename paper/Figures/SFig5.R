library(ggpubr)
#### read data ####
load("CC_varpar.RData")

#### plot ####
p <- ggplot(tbl, aes(x=V3,y=V6, group=Method, fill=Method, color=Method)) + geom_line() + facet_wrap(~V1, nrow=1) + 
  geom_point() + theme_classic(base_size = 8) + theme(strip.background = element_rect(color="black", fill="grey", size=1.5)) + 
  geom_ribbon(aes(ymin=abs(V6-(2*se)),ymax=V6 + (2*se), fill=Method), linetype=0, alpha = 0.3)+ ylim(c(0,0.6)) + ylab("Proportion") + xlab("Causal loci")

ggsave("CC_var_param.png", p, dpi=500)