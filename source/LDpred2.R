library(bigsnpr)
library(ggpubr)
args = commandArgs(trailingOnly=TRUE)
# args 1 Pheno
# args 2 summary stats
# args 3 LOCO chromosome

fileRDS <- paste("data/LOCO_",args[3],".rds",sep="")

obj.bigSNP <- snp_attach(fileRDS)

G   <- obj.bigSNP$genotypes
CHR <- obj.bigSNP$map$chromosome
POS <- obj.bigSNP$map$physical.pos

NCORES <- as.numeric(system2("echo", "$SLURM_JOB_CPUS_PER_NODE",stdout=TRUE))

sumstats <- bigreadr::fread2(args[2])
names(sumstats) <- c("chr", "rsid", "pos", "a0", "a1","n_eff", "af", "beta", "beta_se", "p")

set.seed(1)

map <- obj.bigSNP$map[-(2:3)]
names(map) <- c("chr", "pos", "a0", "a1")
info_snp <- snp_match(sumstats, map)

df_beta <- info_snp[, c("beta", "beta_se", "n_eff")]

ld <- readRDS(paste("data/corr/ld_LOCO",args[3],".rds",sep=""))
corr <- readRDS(paste("data/corr/corr_LOCO",args[3],".rds",sep=""))

(ldsc <- with(df_beta, snp_ldsc(ld, length(ld), chi2 = (beta / beta_se)^2, sample_size = n_eff, blocks = NULL)))
h2_est <- ldsc[["h2"]]

# auto
multi_auto <- snp_ldpred2_auto(corr, df_beta, h2_init = h2_est, vec_p_init = seq_log(1e-4, 0.9, length.out = NCORES), ncores = NCORES)
beta_auto <- sapply(multi_auto, function(auto) auto$beta_est)

G2 <- snp_fastImputeSimple(G, ncores=NCORES)

pred_auto <- big_prodMat(G2, beta_auto)

sc <- apply(pred_auto, 2, sd)
keep <- abs(sc - median(sc)) < 3 * mad(sc)
final_beta_auto <- rowMeans(beta_auto[, keep])
final_pred_auto <- rowMeans(pred_auto[, keep])

PRS <- cbind(obj.bigSNP$fam$family.ID,final_pred_auto)
colnames(PRS) <- c("ID","PGS")

beta_out <- cbind(info_snp, final_beta_auto)
write.table(beta_out, paste("Pred/",args[1],"_pred_auto_LOCO_",args[3],".out",sep=""), quote=F, row.names=F)
write.table(PRS, paste("Pred/",args[1],"_pred_auto_LOCO_",args[3],".PRS.out",sep=""), quote=F, row.names=F)

auto <- multi_auto[[1]]
p <- plot_grid(
  qplot(y = auto$path_p_est) + 
    theme_bigstatsr() + 
    geom_hline(yintercept = auto$p_est, col = "blue") +
    scale_y_log10() +
    labs(y = "p"),
  qplot(y = auto$path_h2_est) + 
    theme_bigstatsr() + 
    geom_hline(yintercept = auto$h2_est, col = "blue") +
    labs(y = "h2"),
  ncol = 1, align = "hv"
)
ggsave(plot=p,filename=paste("Pred/",args[1],"_LOCO_",args[3],".png",sep=""), device="png")

