source scripts/common.sh

PROJECT_ID=$1
CMD_PREFIX=$2

bold "${CMD_PREFIX}Authorise GCP"
${CMD_PREFIX}gcloud auth login
${CMD_PREFIX}gcloud config set project ${PROJECT_ID}
