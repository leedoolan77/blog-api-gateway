source scripts/common.sh

PROJECT_ID=$1
MANAGED_SERVICE=$2
API_ID=$3
API_KEY_ID=$4
CMD_PREFIX=$5

bold "Enable api managed service"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable ${MANAGED_SERVICE}
sleep 5

bold "Generate api key"
${CMD_PREFIX}gcloud --project=${PROJECT_ID}  alpha services api-keys create --display-name=${API_KEY_ID} --api-target=service=${API_ID}
