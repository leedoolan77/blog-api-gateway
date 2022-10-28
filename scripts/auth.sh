source scripts/common.sh

PROJECT_ID=$1
CMD_PREFIX=$2

bold "Authorise GC - using gcloud auth login --update-adc"
${CMD_PREFIX}gcloud auth login --update-adc
${CMD_PREFIX}gcloud config set project ${PROJECT_ID}
