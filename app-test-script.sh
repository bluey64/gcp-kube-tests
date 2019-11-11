#!/bin/bash
# Make sure to do a kubectl get services to get the service IP for the test
# app and create the and export IP=<ip address of service> 
# export IP=<ip address of service>
#export ITIP=`gcloud compute instances list |grep -i gke | awk '{ print $5 }' | head -n1`
#echo "ssh $ITIP -l <sshid>"
export IP=`kubectl get services | grep springbootapp | awk '{ print $4 }'`
echo "watch -p 'curl $IP:8080; curl $IP:8080/query; curl $IP:8080/bad'"

