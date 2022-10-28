source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
FUNCTION=$3
REGION=$4
CMD_PREFIX=$5

bold "Create the function & give the IAM user invoke access"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} functions delete ${FUNCTION} \
--region ${REGION}