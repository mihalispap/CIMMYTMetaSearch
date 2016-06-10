#!/bin/bash

total="$(ls -l toenrich | grep xml | wc -l)"
enriched="0"
echo ${total}

let "total=${total}-10"

#cat tmp/enricher.log | grep 'Record' > tmp/temp #| sed -ne 's/Record:\(.*\) Enrichments:\(.*\)/\1/g')"
#sed -i 's/Record:\(.*\) Enrichments:\(.*\)/\1/g' tmp/temp
#cat tmp/temp

#echo ${vals}

echo ${total}
#exit

while [ $enriched -lt $total ];
do

	cat tmp/enricher.log | grep 'Record' > tmp/temp #| sed -ne 's/Record:\(.*\) Enrichments:\(.*\)/\1/g')"
	sed -i 's/Record:\(.*\) Enrichments:\(.*\)/\1/g' tmp/temp
	sed -i 's/_/\./g' tmp/temp
	#cat tmp/temp

	filename=tmp/temp
	while read -r line
	do
		cd toenrich
		rm *${line}*
		cd ../
	done < "$filename"

	#exit
	cd enricher/bin
	java -classpath ".:../lib/*" -Xss64M -Xmx2048M com.agroknow.cimmyt.Enrich ../../toenrich ../../enriched >> ../../tmp/enricher.log
	echo "Ended\n-----------------"
	cd ../../
	enriched="$(cat tmp/enricher.log | grep 'Record' | wc -l)"

done

exit

cd enricher/bin
java -classpath ".:../lib/*" -Xss64M -Xmx2048M com.agroknow.cimmyt.Enrich ../../toenrich ../../enriched > ../../tmp/enricher.log
