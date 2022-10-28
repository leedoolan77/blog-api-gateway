source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
REGION=$3
API_ID=$4
API_GATEWAY_ID=$5
MANAGED_SERVICE=$6
API_KEY_ID=$7
CMD_PREFIX=$8

bold "Disable api managed service"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services disable ${MANAGED_SERVICE}
sleep 5

bold "Delete api gateway"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway gateways delete ${API_GATEWAY_ID} \
--location=${REGION}
sleep 5

bold "Delete api config"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway api-configs delete ${API_ID}-config \
--api=${API_ID}
sleep 5

bold "Delete api"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway apis delete ${API_ID}
