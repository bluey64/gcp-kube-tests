#!/bin/bash
# If you set your APIKEY as a variable in you terminal you will not have to enter it each time
# you run the script.  This script loads the RBAC for the Datadog Daemonset and puts the API Key as
# secret in your Kube so it is not required in the Datadog Agent YAML file.
if [ -z "$APIKEY" ]
then
echo "Please enter your Datadog API Key:"
read APIKEY
fi
if [ -n "$APIKEY" ]
then
echo "Creating role for Kube State Metrics"
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format='value(config.account)') &> /dev/null

echo "Deploying Kube State Metrics"
kubectl apply -f dd-configs/kube-state-metrics

echo "Creating the API secret"
kubectl create secret generic datadog-secret --from-literal api-key="$APIKEY"

echo "installing the ClusterRole for DD"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"

echo "Creating the Service Account for DD"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"

echo "Creating the Cluster Bind Role"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"

echo "Creating default Config map"
kubectl create configmap datadogtoken --from-literal="event.tokenKey"="0"

echo "Creating the DaemonSet for Datadog"
kubectl create -f dd-configs/datadog-agent.yaml
else
echo "Please enter API key for Datadog and run the script again."

fi
