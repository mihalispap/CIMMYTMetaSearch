#!/bin/bash

cdate="$(date +%Y-%m-%d)"
echo $cdate

cd logs
mkdir $cdate
cd ../
mv tmp/* logs/$cdate
zip -r logs/$cdate.logs.zip logs
rm -r logs/$cdate

rm -r tmp

for i in {0..9}
do
	rm toenrich/*$i.xml
	rm enriched/*$i.*.xml
	rm index/json/*$i.*.json
done
