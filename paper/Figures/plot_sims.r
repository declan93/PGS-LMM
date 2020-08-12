library(ggplot2)
library(gridExtra)

d <- read.table("figure_Nsims.txt",h=T)
p1 <- ggplot(data = d, aes(x=N, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered")+ xlab("Sample Size")

Variable number of causal loci

d2 <- read.table("figure_num_casual.txt",h=T)
p2 <- ggplot(data = d2, aes(x=N, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered") + xlab("Number causal variants recovered")

#Variable h2

d3 <- read.table("figure_sim_h2.txt",h=T)
p3 <- ggplot(data = d3, aes(x=h2, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered")

grid.arrange(p1, p2,p3, nrow = 2)
