#!/bin/bash

# Exit immediately on error
set -e

###########################################
#  Environment Variables / Configuration  #
###########################################

# PeopleSoft Plugin Credentials
export ESADMIN_USER=${ESADMIN_USER:-esadmin}
export ESADMIN_PASSWORD=${ESADMIN_PASSWORD:-esadmin}
export PEOPLE_USER=${PEOPLE_USER:-people}
export PEOPLE_PASSWORD=${PEOPLE_PASSWORD:-people}

# Elasticsearch Settings
export CLUSTER_NAME=${CLUSTER_NAME:-psescluster}
export HTTP_PORT=${HTTP_PORT:-9200}
export HTTP_ENABLE=${HTTP_ENABLE:-true}
export HTTP_CORS_ENABLE=${HTTP_CORS_ENABLE:-true}
export HTTP_CORS_ALLOW_ORIGIN=${HTTP_CORS_ALLOW_ORIGIN:-'*'}
export NETWORK_HOST=${NETWORK_HOST:-_site_}
export NODE_MASTER=${NODE_MASTER:-true}
export NODE_DATA=${NODE_DATA:-true}
export NAMESPACE=${NAMESPACE:-default}

# Cloud Plugin Settings & Credentials
export DISCOVERY_SERVICE=${DISCOVERY_SERVICE:-pselasticsearch-discovery}
export NUMBER_OF_MASTERS=${NUMBER_OF_MASTERS:-1}
export AZURE_STORAGE_ACCOUNT=${AZURE_STORAGE_ACCOUNT:-""}
export AZURE_STORAGE_KEY=${AZURE_STORAGE_KEY:-""}
export KUBERNETES_MASTER=${KUBERNETES_MASTER:-kubernetes}  # Fix for Kubernetes API TLS error

###############
#  Functions  #
###############

function echoinfo() {
  local GC="\033[1;32m"
  local EC="\033[0m"
  printf "${GC} ☆  INFO${EC}: %s\n" "$@";
}

function set_node_name() {
  # Set a random node name if not set.
  echoinfo "Assigning node name"
  if [[ -z "${NODE_NAME}" ]]; then
    NODE_NAME=$(uuidgen)
  fi
  export NODE_NAME=${NODE_NAME}
}

function enable_memlock() {
  echoinfo "Enabling memlock"
  # Enable memlock
  ulimit -l unlimited
  # Prevent "Text file busy" errors
  sync
}

function add_elasticsearch_users() {
  echoinfo "Adding Elasticsearch users"
  sudo -E -u elasticsearch /elasticsearch/bin/elasticsearchuser addusersilent "${ESADMIN_USER}" "${ESADMIN_PASSWORD}" admin,read,security
  sudo -E -u elasticsearch /elasticsearch/bin/elasticsearchuser addusersilent "${PEOPLE_USER}" "${PEOPLE_PASSWORD}" read
}

function update_permissions() {
  echoinfo "Updating permissions on /data"
  chown -R elasticsearch:elasticsearch /data
}

function start_elasticsearch() {
  echoinfo "Starting Elasticsearch"
  sudo -E -u elasticsearch /elasticsearch/bin/elasticsearch
}

##########
#  Main  #
##########

set_node_name
enable_memlock
add_elasticsearch_users
update_permissions
start_elasticsearch
