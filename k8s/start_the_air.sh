#!/bin/bash

#set -eo pipefail

function log {
  msg=$1
  echo "[aircloak] $msg"
}

VERSION=air-18.3.1
BASE_FOLDER=/aircloak/air/lib/${VERSION}/priv
CONFIG_FOLDER=${BASE_FOLDER}/config

log "Booting container."
mkdir -p ${CONFIG_FOLDER}/
log "ls priv/"
ls -l ${BASE_FOLDER}/
log "ls /runtime_config"
ls -l /runtime_config
#log "copying..."
#cp -rp /runtime_config/* ${CONFIG_FOLDER}/

log "cat to the rescue"
cat /runtime_config/config.json > ${CONFIG_FOLDER}/config.json

log "copied the config, ls /priv/config"
ls -l ${CONFIG_FOLDER}/
log "chmodding"
chown deployer:deployer -R ${CONFIG_FOLDER}/
log "after chmodding, ls /priv/config"
ls -l ${CONFIG_FOLDER}/
log "now booting..."
exec gosu deployer /aircloak/air/bin/air foreground
