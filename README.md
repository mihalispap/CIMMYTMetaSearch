# CIMMYT MetaSearch Module

### Installation Instructions

	Ubuntu OS:
		To install the module, simply run **install.sh** with sudo rights (tested on Ubuntu 14.04)
	CentOS:
		You may follow the process described in install.sh. 
		You can download elasticsearch rpm from [the website of elasticsearch](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.noarch.rpm)
		The rest of the process is pretty straight forward.

### Execution as a Cron Job

	The module is designed to work in an automated manner without the need for human interaction.
	To do so, simply set a cron job on your server, executing **msmanager.sh** at the desired frequency.

### Configuration

	Both of the **harvester** and **enricher** java projects have the same *config.properties* located
	at *{harvester,enricher}/resources/config.properties*. One can activate or deactivate enrichments
	performed on the processed resources this way, by setting 1 or 0 to the equivalent values respectively.
