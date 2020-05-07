#!/bin/bash
source "${PWD}/config.txt"


for i in {1..22}; do 
	for j in {1..22}; do
		if [ $i != $j ]; then
		#awk -v chr="$j" '$3 != chr {print $0}' ${PGS}/SBayesR_${j}.snpRes >> ${PGS}/plink_${i}; 
			awk '$10 > .2 {print $0}' ${PGS}/SBayesR_${j}.snpRes >> ${PGS}/plink_${i}; 
		fi;
	done;
	sed -i -e '3,${/^    Id/d' -e '}' ${PGS}/plink_${i};
	awk '{print $2,$5,$8}' ${PGS}/plink_${i} > ${PGS}/plink_${i}_run
done

