#!/bin/bash

midoapi_cmd="midonet-cli -A --midonet-url=http://127.0.0.1:8080/midonet-api -e"

tz=${1}
host=${2}

tz_id=$($midoapi_cmd list tunnel-zone name ${tz} | awk '{ print $2 }')
[ ! "${tz_id}" ] && echo Error: tunnelzone ${tz} not found && exit 1

mido_hosts=$($midoapi_cmd host list)

host_ip=$(getent hosts ${host} | awk '{ print $1 }')
host_id=$($midoapi_cmd list host name ${host} | awk '{ print $2 }')
echo $($midoapi_cmd tunnel-zone ${tz_id} add member host ${host_id} address ${host_ip})
