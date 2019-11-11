
# gcp-kube-tests

This is a description of the scripts in the directory.  Before running
you can export several variables which will make this go much faster.

Log into Datadog and get your API-KEY
 
    export APIKEY=<your Datadog instance API KEY>

 Log into GCP and create a project or lookup an exiting project name
 or use "gcloud projects list" to get a list of projects

    export PROJECT=<Project name in GCP>

 Set a cluster name

    export CLUSTERNAME=<name of your kube cluster in gcp>

 Now that you have done this run the fisrt script

    ./Kube-create.sh
 This will create the Kube cluster in GCP

 Next Run the Datadog install script
 
    ./DD-install-kube.sh

 This will install the the kube state metrics and rbac configuration
 for the Datadog Daemonset.  As well as creates a secret for the API key.
 Then is deploys the Daemonset.

 Now show that the Daemonset is up and running using:
 
    kubectl get pods
    
 There should be 3 pods for Datadog running.

 Now deploy the APP's.
 
    ./APP-create.sh
 
 This will deploy a springboot app with a postgres backend.

 Once that is complete run the app test script it will give you the details to 
 ssh and generate application traces.  Also make sure you have watch installed on
 your computer before running this script.
 
   ./app-test-script.sh

