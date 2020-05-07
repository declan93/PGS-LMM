#!/bin/bash
source "${PWD}/config.txt"

# hash age file using ID as key and covar as val. print evectors with age covar appended. 
for i in {1..22}; do
	awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' $age ${GT}/pca.eigenvec > ${traits}/qcovars2_${i}.txt
	awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' $batch ${traits}/qcovars2_${i}.txt > ${traits}/qcovars3_${i}.txt
	#awk 'NR==FNR{a[$1]=$5;next}{print $0,a[$1] ? a[$1] : "NA"}' ${PGS}/${i}.sscore ${traits}/qcovars3_${i}.txt > ${traits}/qcovars_${i}   #SBayesfixed effect. If you run sbayesr uncomment this line and comment the next one. 
	awk 'NR==FNR{a[$1]=$3;next}{print $0,a[$1] ? a[$1] : "NA"}' ${PGS}/PGS.${i}.all.score ${traits}/qcovars3_${i}.txt > ${traits}/qcovars_${i}  # This line include PRSice LOCO-PGS
	var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch PGS"
	sed -i "1s/.*/$var/" ${traits}/qcovars_${i}
	rm ${traits}/qcovars2_${i}.txt
	rm ${traits}/qcovars3_${i}.txt
done

