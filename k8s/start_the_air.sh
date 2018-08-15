#!/bin/bash

#set -eo pipefail

function log {
  msg=$1
  echo "[aircloak] $msg"
}

BASE_FOLDER=/aircloak/air/lib/air-18.3.0/priv
CONFIG_FOLDER=${BASE_FOLDER}/config

log "Booting container."
mkdir -p /aircloak/air/lib/air-18.3.0/priv/config/
log "ls priv/"
ls -l /aircloak/air/lib/air-18.3.0/priv/
log "ls /runtime_config"
ls -l /runtime_config
#log "copying..."
#cp -rp /runtime_config/* /aircloak/air/lib/air-18.3.0/priv/config/

log "cat to the rescue"
cat /runtime_config/config.json > /aircloak/air/lib/air-18.3.0/priv/config/config.json

log "copied the config, ls /priv/config"
ls -l /aircloak/air/lib/air-18.3.0/priv/config/
log "chmodding"
chown deployer:deployer -R /aircloak/air/lib/air-18.3.0/priv/config/
log "after chmodding, ls /priv/config"
ls -l /aircloak/air/lib/air-18.3.0/priv/config/
log "now booting..."
exec gosu deployer /aircloak/air/bin/air foreground
