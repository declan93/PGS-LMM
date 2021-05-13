library(ramwas)
library(data.table)

# pass summary stats for each phenotype ie Rscript plots.R fGWA fGWAPT fGWALdp BOLT phenotype_out
args <- commandArgs(TRUE)

#### read data ####
S1 <- fread(args[1],h=T) # fastGWA
S2 <- fread(args[2],h=T) # fastGWA-PGS-PT
S3 <- fread(args[3],h=T) # fastGWA-PGS-LDpred2
S4 <- fread(args[4],h=T) # BOLT-LMM
S4$P_BOLT_LMM[is.na(S4$P_BOLT_LMM)] <- 1
output <- args[5] 

P1 <- sort(-log(S1$P,10))
P2 <- sort(-log(S2$P,10))
P3 <- sort(-log(S3$P,10))
P4 <- sort(-log(as.numeric(as.character(S4$P_BOLT_LMM)),10))

png(paste0(output,'.png'))
par(mfrow=c(2,2))
plot(P1,P2, xlab="fastGWA -log10(P)",ylab="fastGWA-PT -log10(P)")
abline(0,1)
plot(P1,P3, xlab="fastGWA -log10(P)",ylab="fastGWA-LDpred2 -log10(P)")
abline(0,1)
plot(P3,P4, xlab="fastGWA-LDpred2 -log10(P)",ylab="BOLT-LMM -log10(P)")
abline(0,1)
plot(P1,P4, xlab="fastGWA -log10(P)",ylab="BOLT-LMM -log10(P)")
abline(0,1)
dev.off()
