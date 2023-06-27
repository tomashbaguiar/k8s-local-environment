#!/bin/bash

# Verify k8s cluster
IS_RUNNING=$(kubectl cluster-info --context kind-local | grep -E '(running)')

if [[ $IS_RUNNING = '' ]]; then
    # Create k8s cluster
    exec kind create cluster -n local
fi

# Deployments
# get list of deployment yaml files
DEPLOYMENT_LIST=(`ls -1 | grep -E 'deploy.y(a|)ml'`)

COMMAND='kubectl delete'

for DEPLOYMENT in ${DEPLOYMENT_LIST[@]}; do
    COMMAND+=" -f ${DEPLOYMENT}"
done

# Delete deployment by files
exec $COMMAND ${1}

# Remove Camunda Platform
helm uninstall -f camunda-platform-core-kind-values.yaml

# Remove Cluster
kind delete cluster -n local

