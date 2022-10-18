# main vars & includes
SHELL=/bin/bash
DRY_RUN=False # use this just to see commands

# default vars to run initial build from/to
GCP_BILLING_ACCOUNT_ID?=<CHANGE ME> # Billing Account ID - to attach your api project to'
GCP_FOLDER?=<CHANGE ME> # Folder to place api project
GCP_PROJECT?=<CHANGE ME> #Default project - nothing actually created here, just used for initial api project creation

API_PROJECT?=<CHANGE ME>
API_REGION?=europe-west2
API_IAM_ACCOUNT?=api-stream-account
API_FUNCTION?=api-stream-to-pubsub

API_ID?=api-stream
API_GATEWAY_ID?=api-stream-gateway
API_KEY_ID?=api-stream-key

API_MANAGED_SERVICE?=<CHANGE ME WHEN KNOWN>
API_GATEWAY_URL?=<CHANGE ME WHEN KNOWN>
API_KEY?=<CHANGE ME WHEN KNOWN>

# apply dry run if required, useful for testing
ifeq (${DRY_RUN}, True)
  CMD_PREFIX='echo '
endif

.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))
namespace?=$$(whoami | tr '[:upper:]' '[:lower:]' | tr -d '.')

.DEFAULT_GOAL := help

help: ## This is help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

auth: ## GC authenticate & set default project
	@scripts/$@.sh ${GCP_PROJECT} ${CMD_PREFIX}

project: ## Setup api project
	@scripts/$@.sh ${GCP_BILLING_ACCOUNT_ID} ${GCP_FOLDER} ${API_PROJECT} ${CMD_PREFIX}

pubsub: ## Setup pubsub
	@scripts/$@.sh ${API_PROJECT} ${API_IAM_ACCOUNT} 'sales-api-stream' ${CMD_PREFIX}
	@scripts/$@.sh ${API_PROJECT} ${API_IAM_ACCOUNT} 'product-api-stream' ${CMD_PREFIX}

function: ## Setup cloud function
	@scripts/$@.sh ${API_PROJECT} ${API_IAM_ACCOUNT} ${API_FUNCTION} ${API_REGION} ${CMD_PREFIX}

api_create: ## Create our api and gateway
	@scripts/$@.sh ${API_PROJECT} ${API_IAM_ACCOUNT} ${API_REGION} ${API_ID} ${API_GATEWAY_ID} ${CMD_PREFIX}

api_describe: ## Describe our created api and gateways
	@scripts/$@.sh ${API_PROJECT} ${API_REGION} ${API_ID} ${API_GATEWAY_ID} ${CMD_PREFIX}

api_key: ## Enable api managed service & generate key
	@scripts/$@.sh ${API_PROJECT} ${API_MANAGED_SERVICE} ${API_ID} ${API_KEY_ID} ${CMD_PREFIX}

api_test: ## send test messages to our api gateway
	@scripts/$@.sh ${API_PROJECT} ${API_GATEWAY_URL} ${API_KEY} 'sales' 'sales-api-stream' ${CMD_PREFIX}
	@scripts/$@.sh ${API_PROJECT} ${API_GATEWAY_URL} ${API_KEY} 'product' 'product-api-stream' ${CMD_PREFIX}

