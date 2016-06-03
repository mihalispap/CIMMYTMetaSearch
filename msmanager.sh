#!/bin/bash

timestamp=$(date +%s)

mkdir tmp

cd config/
filename="oai.targets"

echo "Starting harvesting process"
echo "---------------------------"

while read -r line
do

	url_name=$(echo ${line} | tr "\t" "\n")
	IFS=', ' read -r -a arr <<< "${url_name}"

	cd ../data
	mkdir ${arr[1]}

	cd ../harvester/bin
	java -classpath ".:../lib/*" -Xss64M -Xmx2048M gr.agroknow.cimmyt.HarvestManager ${arr[0]} ../../data/${arr[1]} "oai_dc" >> ../../tmp/output.log

	#echo ${arr[0]}
	cd ../../config
done < "$filename"

echo "---------------------------"
echo "Harvesting process complete"

#exit

echo "Initializing internal transformation process"
cd ../data

for d in */ ; do
	mv ${d}/*.xml ../internaltransformer/input
	cd ../internaltransformer
	java -jar saxon9he.jar -xsl:cimmyt.xsl -s:input -o:output
	mv input/*.xml ../backup
	cd ../data
done
echo "Transformation complete"

cd ../
mkdir toenrich
mv internaltransformer/output/*.xml toenrich

echo "Starting enrichment process"
echo "---------------------------"

cd enricher/bin
java -classpath ".:../lib/*" -Xss64M -Xmx2048M com.agroknow.cimmyt.Enrich ../../toenrich ../../enriched > ../../tmp/enricher.log

echo "Enrichment process complete"

cd ../../

echo "Conversion to json initialize"
cd 2jsontransformer/bin
java -classpath ".:../lib/*" -Xss64M -Xmx2048M Transformer ../../enriched ../../index/json
echo "Conversion complete"

echo "Indexing process initialization"
cd ../../index
./index_all.sh > ../tmp/indexer.log
cd ../
echo "Indexing complete!"

current_timestamp=$(date +%s)
let "diff_time=${current_timestamp}-${timestamp}"
cd notify
./sendmail.sh ${diff_time}
cd ..


rm toenrich/*.xml
rm enriched/*.xml
rm index/json/*.json
rm -r tmp

current_timestamp=$(date +%s)
let "diff_time=${current_timestamp}-${timestamp}"
echo "Total time elapsed: "${diff_time}"secs"
