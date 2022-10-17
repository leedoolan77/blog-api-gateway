source scripts/common.sh

GCP_BILLING_ACCOUNT_ID=$1
GCP_FOLDER=$2
PROJECT_ID=$3
CMD_PREFIX=$4

bold "${CMD_PREFIX}Create api project and attach billing account'
${CMD_PREFIX}gcloud projects create ${PROJECT_ID} --folder=${GCP_FOLDER} --name=${PROJECT_ID}
${CMD_PREFIX}gcloud alpha billing projects link ${PROJECT_ID} --billing-account ${GCP_BILLING_ACCOUNT_ID}
