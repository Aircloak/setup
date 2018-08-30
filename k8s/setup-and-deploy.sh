#!/usr/bin/env bash

set -e

cd $(dirname $0)

NAMESPACE=${1:-aircloak}

function log {
  echo "[aircloak]: ${1}"
}

log "Starting test kubernetes setup of Aircloak Insights"

if ! kubectl get namespace | grep "${NAMESPACE}" > /dev/null; then
  log "Deploying to namespace ${NAMESPACE}"
else
  echo
  echo "WARNING: existing namespace ${NAMESPACE} will be recreated."
  echo "This will delete all existing deployments in the namespace!"
  read -p "Continue (y/N)? " -r
  if ! [[ $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

  log "Removing existing namespace ${NAMESPACE}"
  kubectl delete namespace ${NAMESPACE}
fi

kubectl create namespace ${NAMESPACE}

log "Creating secrets"

### air-db config
kubectl --namespace=${NAMESPACE} create secret generic air-db-config-secret \
  --from-file=../docker-compose/config/air_db/config.json

### air config
kubectl --namespace=${NAMESPACE} create secret generic air-config-secret \
  --from-file=../docker-compose/config/air/config.json

### cloak config
kubectl --namespace=${NAMESPACE} create configmap cloak-configmap \
  --from-file=../docker-compose/config/cloak \
  --from-file=../docker-compose/config/cloak/data_sources

log "Creating volume claims, deployments, and services"

for file in ./*.yaml; do
  kubectl --namespace=${NAMESPACE} apply -f ${file}
done
