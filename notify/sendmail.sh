#!/bin/bash

filename="../config/mail.accounts"

newline=$'\n'

while read -r line
do
	echo "Contacting:"${line}

	mail_message="Harvesting information"
	mail_message="${mail_message}"'\n'"----------------------"

	general_info=$(cat ../tmp/output.log | grep " Sets:")

	mail_message="${mail_message}"'\n'"${general_info}"'\n''\n'
	mail_message="${mail_message}Specific per set information follows (format: Set(<set_spec>):#of_resources_harvested)"'\n'
	mail_message="${mail_message}--------------------------------------------------------------------------------------"

	spec_info=$(cat ../tmp/output.log | grep "Set(")
	mail_message="${mail_message}"'\n'"${spec_info}"

	spec_info=$(cat ../tmp/output.log | grep "All:")
        mail_message="${mail_message}"'\n'${spec_info}" [contains records not present in sets]"

	enrich_info=$(cat ../tmp/enricher.log | grep "Record")
	mail_message="${mail_message}"'\n\n\n'"Enrichment information"'\n'
	mail_message="${mail_message}----------------------"'\n'"${enrich_info}"

	index_prev=$(cat ../tmp/indexer.log | grep "\"created\":false" | wc -l)
	index_new=$(cat ../tmp/indexer.log | grep "\"created\":true" | wc -l)

	mail_message="${mail_message}"'\n\n\n'"Indexing information"'\n'
	mail_message="${mail_message}--------------------"'\n'"New entities indexed:"${index_new}'\n'"Updated entities:"${index_prev}
	mail_message="${mail_message}"'\n\n\n'"Total time elapsed:"$1"secs"

	sendemail -f cimmyt.api@agroknow.com -t ${line} -u "CIMMYT MetaSearch Module Execution" -m "${mail_message}" -s smtp.agroknow.com:587 -xu cimmyt.api@agroknow.com -xp 181MuRNE -o tls=no

	smail=$?
	if [ $smail -ne 0 ];
	then
		sendemail -f cimmyt.api@agroknow.com -t ${line} -u "CIMMYT MetaSearch Module Execution: Harvester Info" -m "${general_info}" -s smtp.agroknow.com:587 -xu cimmyt.api@agroknow.com -xp 181MuRNE -o tls=no
		sendemail -f cimmyt.api@agroknow.com -t ${line} -u "CIMMYT MetaSearch Module Execution: Enricher Info" -m "${enrich_info}" -s smtp.agroknow.com:587 -xu cimmyt.api@agroknow.com -xp 181MuRNE -o tls=no
		mail_message="--------------------"'\n'"New entities indexed:"${index_new}'\n'"Updated entities:"${index_prev}
		sendemail -f cimmyt.api@agroknow.com -t ${line} -u "CIMMYT MetaSearch Module Execution: Indexer Info" -m "New entities indexed:"${index_new}'\n'"Updated entities:"${index_prev} -s smtp.agroknow.com:587 -xu cimmyt.api@agroknow.com -xp 181MuRNE -o tls=no
	fi
	echo $?

done < "$filename"

#sendemail -f AMM@agroknow.com -t mihalis.papakonstadinou@agroknow.com -u "Harvested $1" -m "my testing" -s smtp.agroknow.com:587 -xu amm.harvester@agroknow.com -xp OvDjYDgL3m

#sendemail -f AMM@agroknow.com -t mihalis.papakonstadinou@agroknow.com -u "Harvested $1" -m $3 -s smtp.agroknow.com:587 -xu
