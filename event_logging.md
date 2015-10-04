#Sending Event Data to  influxDB

This guide will define the methods and best practices associated with sending event data to *influxDB* via the HTTP API.  It is important to carefully think about the data structure prior to logging a new type of event, as changing at a later date will require additional data-transoformation activities.

## Data Syntax

[https://influxdb.com/docs/v0.9/guides/writing_data.html](The official guide) 

The data syntax for an event:

measurement[,tags] [fields] [timestamp]

There are three different groups of data. Tags, fields and a timestamp.  The measurement is a special kind of tag that has no associated value.  It is always the first tag and is required.  Tags describe the measurement or conditions related to the measurement. Fields are the values that are measured.  The timestamp represents the time of the measurement. If the timestamp is omitted, *influxDB* will set the time to when the event is received.

### Measurement

The measurement is the name of the data series in the influxDB database. For example, if you want to store the time required to run the valve query, a suitable measurement name would be 'Valve_Query'.

### Tags

Tags are additional information, in the form of key-value pairs, that can be used to filter and group the query results. They are normally things that pertain to the measurement being made, but are not actually measurements.  Some examples for the valve query would be ',user=user_name,project=project_name,citrix_server=CNBAD03'. Tags are optional and each key-value pair is separated by a coma.

### Fields

Fields are the data being measured, also listed as comma-separated key-value pairs. Some examples would be '"durattion"=1292.2,rows=2012i'.  Please note that 'duration' is in quotes, because 'duration' is a reserved word in influxDB and will cause a failure if left un-quoted. 'rows' is not a reserved word and can be left unquoted.  The value for rows has an 'i' at the end, which signifies that the value is an integer.  Plain numbers will be considered floats.  At least one field is required per event.  Fields are not indexed in the database.

### Timestamp
This value is a 64bit integer, representing the number of nanoseconds since Jan 1st, 1970.  Check the docs, for using other versions (miliseconds or even seconds).  Be aware that timestamps should normally represent UTC timezone, but if you server is located in a different timezone, it may filter according to local time, which may lead to some data not showing up.  Check Grafana setting on how to resolve this.  The timestamp can be omitted. InfluxDB will set the time according to when it receives the request, in the servers local time zone.

### Escaping ',' and spaces

If the key or value name includes comma's or spaces, they must be escaped with a backslash (\).  Example: 'Valve\ Query, user=Medding\,\ Jon'.  The space separating the tags and fields and fields and timestamp does not need to be escaped.  In general, try to choose keys that do not require escaping as this will make using the manual data exploration tools easier.

### Full example

The HTTP request should be a POST request and include the relevant username and password in the query parameters.  Here is a sample curl request.

`curl -i -XPOST 'http://localhost:8086/write?db=COMOS&u=citrix&p=alstom' --data-binary 'cpu\ load,host=server01,region=us-west value=0.64

Please note that the URL needs to be adapted to the actual influxDB server's IP address.