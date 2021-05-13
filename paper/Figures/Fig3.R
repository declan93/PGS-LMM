library(data.table)
library(ggpubr)
library(dplyr)

#### read data ####
load("Fig3.RData")
#### plot ####

p100 <- ggplot(tbl100_out, aes(x=Nc,y=Prop, group=Method, fill=Method, color=Method)) + ggtitle("100K") + geom_line() + facet_wrap(~herit, nrow=1) + 
  geom_point() + theme_classic(base_size = 8) + 
  theme(axis.title.x=element_blank(), axis.title.y=element_blank(), strip.background = element_rect(color="black", fill="grey", size=1.5)) + 
  geom_ribbon(aes(ymin=Prop-(2*se),ymax=Prop + (2*se), fill=Method), linetype=0, alpha = 0.3)+ ylim(c(0,0.85))

p430 <- ggplot(tbl400_out, aes(x=Nc,y=Prop, group=Method, fill=Method, color=Method)) + 
  ggtitle("430K") + geom_line() + facet_wrap(~herit, nrow=1) + geom_point() + theme_classic(base_size = 8) + 
  theme(axis.title.x=element_blank(), axis.title.y=element_blank(), strip.background = element_rect(color="black", fill="grey", size=1.5)) + 
  geom_ribbon(aes(ymin=Prop-(2*se),ymax=Prop + (2*se), fill=Method), linetype=0, alpha = 0.3)+ ylim(c(0,0.85))

fig <- annotate_figure(ggarrange(p100,p430,ncol=1, common.legend=T, labels=c("A","B")), 
                       left = text_grob("Proportion", rot = 90), bottom= text_grob("Causal loci") )

ggsave("variable_paramQ.png", fig, dpi=500)


#### tablulate ####
tex430 <- tbl400_out %>% group_by(herit,Method,Nc) %>% summarise(med = median(Prop)) %>% xtable()
tex100 <- tbl100_out %>% group_by(herit,Method,Nc) %>% summarise(med = median(Prop)) %>% xtable()