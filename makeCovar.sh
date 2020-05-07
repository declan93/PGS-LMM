#!/bin/bash
source "${PWD}/config.txt"

# hash age file using ID as key and covar as val. print evectors with age covar appended. 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' $age ${GT}/pca.eigenvec > ${traits}/qcovars2.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' $batch ${traits}/qcovars2.txt > ${traits}/qcovars.txt

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch"
sed -i "1s/.*/$var/" ${traits}/qcovars.txt


awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' $centre <(awk '{print $1, $1}' ${traits}/qcovars.txt) > ${traits}/fixed2.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' $sex ${traits}/fixed2.txt > ${traits}/fixed.txt
rm ${traits}/fixed2.txt
rm ${traits}/qcovars2.txt
var2="FID IID centre sex"
sed -i "1s/.*/$var2/" ${traits}/fixed.txt
