# influx_grafana
The goal is to have an easily deployable application that can receive incoming events and the display those events as lists or charts via a simple, but powerful web-based query interface.

the Influx DB and Grafana combination fit very well. Docker, and docker-compose are the easiest ways to deploy and configure.  In this setup, both InfluxDB and Grafana run on the same host, but in separate docker containers.  It will be strait forward to move them to separate hosts later, if desired.

## Setup
Clone this repo on the desired host and run 
    
`docker-compose up`
    
    
We use the [totem docker container](https://github.com/tutumcloud/influxdb) for InfluxDB.  Please refer to it for configuration details.

We use the [Grafana docker container](http://docs.grafana.org/installation/docker/) for Grafana.

### Influx Ports
#### 8083
The web based interface is available on this port  (http:\\localhost:8083)
#### 8086
The HTTp API is available on this port.  The InfluxDB CLI and Grafana will communicate with InlfuxDB via this port.

### Grafana Ports
#### 3000
Connect to the web portal via http:\\localhost:3000

### Grafana Data Sources
If you configure your datasource without proxy, then you need to point it to the host of the InfluxDB docker container. Probably http:\\localhost:8086.  If you use the proxy setting, then you need to use the name that docker-compose gives to the influx container.  It's probably something like http:\\influx-grafana-1:8086.

Run `docker ps` to see the names of your containers.
