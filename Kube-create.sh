#!/bin/bash
# This script creates the Kube instance in GCP
# it uses us-central1-a as the region

if [ -z "$CLUSTERNAME" ]
then
echo "Enter Cluster Name:"
read CLUSTERNAME
fi

if [ -z "$PROJECT" ]
then
echo "Enter Google project name:"
read PROJECT
fi

if [ -n "$CLUSTERNAME" -a "$PROJECT" ]
then
echo "Creating Cluster"
gcloud container clusters create $CLUSTERNAME --zone us-central1-a --machine-type=n1-standard-8 --node-locations us-central1-a --num-nodes=3 &> /dev/null

echo "Setting up kubectl"
gcloud container clusters get-credentials $CLUSTERNAME --zone us-central1-a --project $PROJECT &> /dev/null
else
echo "Enter Cluster Name and Project name, then run script again."
fi

