source scripts/common.sh

PROJECT_ID=$1
REGION=$2
API_ID=$3
API_GATEWAY_ID=$4
CMD_PREFIX=$5

bold "Describe api and api gateway service"
bold "API"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway apis describe ${API_ID}

bold "API GATEWAY"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway gateways describe ${API_GATEWAY_ID} \
--location=${REGION}