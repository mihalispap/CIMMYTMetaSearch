#!/bin/bash

if [ "$(whoami)" != "root" ]; then
	echo "Need to run with sudo rights!"
	exit -1
fi

echo "Unzipping projects..."
	unzip cimmyt_metasearch.zip
echo "Unzipping complete"

echo "Setting up elasticsearch"
echo "------------------------"

echo "Downloading deb file..."
	wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.2.deb
echo "Download complete"

echo "Installing elasticsearch..."
	sudo dpkg -i elasticsearch-1.5.2.deb
echo "Install complete"

echo "Updating elasticsearch configuration file..."
	sudo sh -c "echo \"cluster.name: agroknow\" >> /etc/elasticsearch/elasticsearch.yml"
	sudo sh -c "echo \"node.name: cimmyt_node\" >> /etc/elasticsearch/elasticsearch.yml"
	sudo sh -c "echo \"node.rack: local\" >> /etc/elasticsearch/elasticsearch.yml"
	sudo sh -c "echo \"node.zone: main\" >> /etc/elasticsearch/elasticsearch.yml"
	sudo sh -c "echo \"http.port: 9201\" >> /etc/elasticsearch/elasticsearch.yml"
echo "Configuration file update complete"

echo "Installing necessary plugins.."
	sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
	sudo /usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk
	sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.5.0
echo "Plugin installation complete"

echo "Starting service.."
	sudo service elasticsearch start
echo "Elasticsearch service started, if no errors are present there is a working interface: http://localhost:9201/_plugin/head"

echo "Creating elasticsearch index..."
	cd index
	./create_index.sh
	mkdir json
	cd ../
echo "Creation complete"
