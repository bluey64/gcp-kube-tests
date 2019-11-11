#!/bin/bash
# This script delets the Kube instance in GCP
# it uses us-central1-a as the region

if [ -z "$CLUSTERNAME" ]
then
echo "Enter Cluster Name:"
read CLUSTERNAME
fi

if [ -n "$CLUSTERNAME" ]
then
echo "Deleting Kube Cluster on GCP!"
gcloud container clusters delete $CLUSTERNAME
else
echo "Enter Cluster Name, then run script again."
fi

