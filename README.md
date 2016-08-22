# CIMMYT MetaSearch Module

## Installation Instructions

**Ubuntu OS**: 
To install the module, simply run **install.sh** with sudo rights (tested on Ubuntu 14.04)

**CentOS**:
You may follow the process described in install.sh. 
You can download elasticsearch rpm from [the website of elasticsearch](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.noarch.rpm)
The rest of the process is pretty straight forward.

After the installation process is complete, one should deploy the war file of
the api at the webapps folder of tomcat. 
In the default case that is: */var/lib/tomcat{version}/webapps* so a simple:
```
sudo cp webapp/cimmyt.war /var/lib/tomcat7/webapps
```
should do.

## Execution as a Cron Job

The module is designed to work in an automated manner without the need for human interaction.
To do so, simply set a cron job on your server, executing **msmanager.sh** at the desired frequency.
The suggested frequency being once a day, preferably at the end of each day.

If everything goes to plan, all one has to do is set up this cron job, and check his emails and at 
respective time, to ensure that all goes to plan.

## Configuration

### Configure Repositories

To add/remove repositories you can edit the *config/oai.targets* file. An example content is:
```
http://data.cimmyt.org/dvn/OAIHandler\tDVN
```
The format of this configuration file is *OAI-PMH target url\tOAI-PMH target internal-ID*. So to:
* add a repository just add a new line in the file,
* edit a repository, edit the equivalent line in the file,
* delete a repository, delete the line in the configuration file.

### Configure Sets in Repositories

By default the MetaSearch Module processes all the sets available in each repository. To exclude some
can be done by adding the set id at *DBHandler.java:174* in the CIMMYTHarvester project.

### Configure New Input Formats

Currently the MetaSearch Module's Harvester, harvests the data in oai_dc metadata format. To support 
another input format for the **Internal Transformer**, create a transformation xsl, similar to the
*internaltransformer/cimmyt.xsl* and then you can edit **msmanager.sh** by adding a line similar
to 46, containing the new xsl.

### Configure Enrichments

Both of the **harvester** and **enricher** java projects have the same *config.properties* file located
at *{harvester,enricher}/bin/resources/config.properties*. One can activate or deactivate enrichments
performed on the processed resources this way, by setting 1 or 0 to the equivalent values respectively.

### Configure Notifications 

The MetaSearchModule comes with **notification capabilities**. This is embeded in the supplied scripts and can be 
further customized through the config file in *config/mail.accounts*. The format of this file is the following: 
*email_account\n*.

### Configure ElasticSearch

Special care should be taken into configuring **Elasticsearch heap size**. This can be done by exporting an environment
 variable ES_HEAP_SIZE, by issuing *export ES_HEAP_SIZE=XXg*. Along with this configuration, one should also pay 
attention to the maximum allowed memory for the java projects. This can be configured through the equivalent parameter 
given at both *msmanager* and *enrich* scripts.

### Toggling Fuzzy Search

To set fuzziness on the search parameters on and off, there is a *config.properties* file located in the *webapp/configuration*
directory. One may find the latest version of the CIMMYTWebApp [here](https://github.com/mihalispap/CIMMYTWebApp). Keep in mind that every change done at this file requires 
another 
```
mvn package
```
of the war file to be deployed in tomcat. Also the resulting war package should be named **cimmyt.war** in 
order for the uris to be valid.
