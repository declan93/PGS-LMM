Dir for replicating simulated figures

### Variable sample size
```
d <- read.table("figure_Nsims.txt",h=T)
ggplot(data = d, aes(x=N, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered")+ xlab("Sample Size")
```

### Variable number of causal loci 
```
d <- read.table("figure_num_casual.txt",h=T)
ggplot(data = d, aes(x=N, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered") + xlab("Number causal variants recovered")
```
### Variable h2
```
d <- read.table("figure_sim_h2.txt",h=T)
ggplot(data = d, aes(x=h2, y=p)) + geom_point(aes(color=method)) +geom_line(aes(colour=method)) + theme_classic() +geom_ribbon(aes(ymin=lwr, ymax=upr,fill=method), linetype=2, alpha=0.1) + ylab("Prop causal variants recovered") + xlab("h2")
```
