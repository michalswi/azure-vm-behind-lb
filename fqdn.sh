#!/usr/bin/env bash

set -e

if [ -z $1 ] && [ -z $2 ]
then
    echo -e "Pls provide IP and hostname e.g.:\n\
${0} <LB_public_IP> <unique_hostname>\n\
curl <hostname>.westeurope.cloudapp.azure.com"
    exit 1
else
    IP=$1
    DNSNAME=$2
fi

PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME
echo -e "IP registered, use this instead:"
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
