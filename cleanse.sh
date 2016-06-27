#!/bin/bash

rm -r tmp

for i in {0..9}
do
	rm toenrich/*$i.xml
	rm enriched/*$i.*.xml
	rm index/json/*$i.*.json
done
