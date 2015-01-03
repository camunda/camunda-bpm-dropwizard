#!/bin/bash

docker run -d -p 3306:3306 -e user="camunda" -e password="camunda" -e right="WRITE" -e url="https://raw.githubusercontent.com/jangalinski/camunda-bpm-dropwizard/master/examples/camunda_mysql.sql" mysqldb
