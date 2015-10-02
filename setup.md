# Setup and Admin
The following instructions are specifically for my usecase, which is to report usage and performance values for an instance of Siemen's COMOS application. This application has one central database that is accessed via a handful of Citrix terminal servers from users all over the world.  The goal is that Comos instances running on the Citrix servers will report *events* to an influxDB instance.  The Comos adminstrators can access the influx DB data via Grafana.

This document details the steps needed to deploy the *influxDB* and *Grafana* instances.  Adapting the Comos application to report events is out of the scope of this document.

## Installation and Startup
InfluxDB and Grafana will be deployed as Docker Containers. This guide and supporting scripts are set up for a single server installation on Ubuntu 14.04 LTS.  It is possible to use other Linux distributions and/or separate servers for the influxDB and Grafana containers but changes will be needed.
* **Multiple Servers:** Look in the *docker-compose* setup to configure multiple servers
* **Other Linux distros:** Adapt the *install.sh* script accordingly  

1. Start with a fresh install of Ubuntu 14.04 LTS

2. Ensure the *git* and *curl* are installed

3. From your user's home directory, clone the git repository: `git clone https://github.com/jmedding/influx_grafana.git`

4. `cd influx_grafana`

5. `sudo bash install.sh`

6.  Note the server's ip address with `ifconfig`.  Check the setting for *ETH0*. If you have `inet addr:10.0.4.23` then your server's <ip address> is *10.0.4.23*.  

7. `sudo docker-compose up`

8. Using a web browser goto *<ip address>:8083*. You should see the influxDB web console. You can now access influxDB as an Admin as there are no access rights configured yet.

9. Using a wev browser goto *<ip address>:3000*. You should see the Grafana login page. You can login as *admin:admin*.

## Create a database for Comos data
1. Access the influxDB web console on port 8083 of the influxDB server.

2. In the *Query* box, enter `CREATE DATABASE COMOS`

3. Check that the response is positive

## Configure User Authentication and Authorization for influxDB

1. Access the influxDB web console on port 8083 of the influxDB server.

2. Create an Admin user *(jon/surfin)*

`CREATE USER "username" WITH PASSWORD 'password' WITH ALL PRIVILEGES`

3. Enable authentication in the influxDB config.toml file by setting `auth-enabled = true` in the `[http]` section.

4. Stop the docker containers with `sudo docker-compose stop` and the rebuild the influx image with `sudo docker-compose build influx`. Restart the containers with `sudo docker-compose up`

5. Create the needed users for the COMOS database
  * **citrix** will write comos app data to influxDB
    *`CREATE USER "citrix" WITH PASSWORD 'alstom'`     
  * **grafana** will read data from influxDB and present it to the users
    *`CREATE USER "grafana" WITH PASSWORD 'alstom'` 

6. Grant the needed privileges to the new users
  * `GRANT WRITE on COMOS to citrix`
  * `GRANT READ on COMOS to grafana`
