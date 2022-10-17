source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
REGION=$3
API_ID=$4
API_GATEWAY_ID=$5
CMD_PREFIX=$6

bold "${CMD_PREFIX}Enable api gateway service"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable apigateway.googleapis.com
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable servicecontrol.googleapis.com
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable servicecmanagement.googleapis.com

bold "${CMD_PREFIX}Create api and api config"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway apis create ${API_ID}
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway api-configs create ${API_ID}-config \
--api=${API_ID} --openapi-spec="API Gateway/api-config.yaml" \
--backend-auth-service-account=${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com

bold "${CMD_PREFIX}Create api gateway using above api and api config"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} api-gateway gateways create ${API_GATEWAY_ID} \
--api=${API_ID} --api-config=${API_ID}-config --location=${REGION}
