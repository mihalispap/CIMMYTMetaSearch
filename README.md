# CIMMYT MetaSearch Module

### Installation Instructions

**Ubuntu OS**: 
To install the module, simply run **install.sh** with sudo rights (tested on Ubuntu 14.04)

**CentOS**:
You may follow the process described in install.sh. 
You can download elasticsearch rpm from [the website of elasticsearch](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.noarch.rpm)
The rest of the process is pretty straight forward.

After the installation process is complete, one should deploy the war file of
the api at the webapps folder of tomcat. 
In the default case that is: */var/lib/tomcat{version}/webapps* so a simple:
**sudo cp webapp/cimmyt.war /var/lib/tomcat7/webapps** should do.

### Execution as a Cron Job

The module is designed to work in an automated manner without the need for human interaction.
To do so, simply set a cron job on your server, executing **msmanager.sh** at the desired frequency.
The suggested frequency being once a day, preferably at the end of each day.

If everything goes to plan, all one has to do is set up this cron job, and check his emails and at 
respective time, to ensure that all goes to plan.

### Configuration

Both of the **harvester** and **enricher** java projects have the same *config.properties* file located
at *{harvester,enricher}/bin/resources/config.properties*. One can activate or deactivate enrichments
performed on the processed resources this way, by setting 1 or 0 to the equivalent values respectively.

**OAI-PMH** targets are configured through config/oai.targets file. The format of this file is: 
*url_of_the_oai\tcustom_id*. This way one can add/remove oai targets. Of course if new oai targets 
are added, in order for the self enrichments to take place, additions should be made to the source code 
of the respective java project. 

The MetaSearchModule comes with **notification capabilities**. This is embeded in the supplied scripts and can be 
further customized through the config file in *config/mail.accounts*. The format of this file is the following: 
*email_account\n*.

Special care should be taken into configuring *Elasticsearch heap size*. This can be done by exporting an environment
 variable ES_HEAP_SIZE, by issuing *export ES_HEAP_SIZE=XXg*. Along with this configuration, one should also pay 
attention to the maximum allowed memory for the java projects. This can be configured through the equivalent parameter 
given at both *msmanager* and *enrich* scripts.
