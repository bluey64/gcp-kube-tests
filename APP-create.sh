#!/bin/bash
# This spins up a springboot app with backend postgres db.
# It has the traceing jar already installed in the container.
# to generate traffic run the app-test-script.sh
# it will out put ssh into a kube node and the curl commands 
# to access the api endpoints to generate traces.

echo "Spinning up postgres Database"
kubectl create -f app-yaml/postgres_deployment.yaml

echo "Starting Springboot app"
kubectl create -f app-yaml/springboot_deployment.yaml
