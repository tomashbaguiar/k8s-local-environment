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

COMMAND='kubectl apply'

for DEPLOYMENT in ${DEPLOYMENT_LIST[@]}; do
    COMMAND+=" -f ${DEPLOYMENT}"
done

# Apply deployment by files
exec $COMMAND ${1}

# Deploy Camunda Platform
helm repo add camunda https://helm.camunda.io
helm repo update
helm install dev camunda/camunda-platform -f camunda-platform-core-kind-values.yaml

