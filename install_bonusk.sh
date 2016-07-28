#!/bin/bash

cd ./; wget http://download.elastic.co/kibana/kibana/kibana-4.1.0-snapshot-linux-x64.tar.gz
#exit

tar xvf kibana-*.tar.gz
# vi ~/kibana-4*/config/kibana.yml
# add host: "localhost"

printf "\nhost: \"localhost\"\n" >> ./kibana-4*/config/kibana.yml

#exit

sudo mkdir -p /opt/kibana
sudo cp -R ./kibana-4*/* /opt/kibana/
cd /etc/init.d && sudo wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4
sudo chmod +x /etc/init.d/kibana4
sudo update-rc.d kibana4 defaults 96 9
sudo service kibana4 start

echo "If followed install.sh script, then you should change kibana<->elasticsearch port from 9200 to 9201 and restart kibana4"
