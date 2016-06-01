#!/bin/bash

content="$(cat index.object | tr -d '\n' | tr -d '\t' | tr -d ' ')"

#curl -XPOST localhost:9201/cimmyt -d '${content}'
#echo "curl -XPOST localhost:9201/cimmyt -d '${content}'"

echo ${content} > index.properties.json
curl -XPUT localhost:9201/cimmyt --data-binary @index.properties.json
