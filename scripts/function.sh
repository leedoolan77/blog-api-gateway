source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
FUNCTION=$3
REGION=$4
CMD_PREFIX=$5

bold "${CMD_PREFIX}Enable required services"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable cloudfunctions.googleapis.com
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable cloudbuild.googleapis.com

bold "${CMD_PREFIX}Create the function & give the IAM user invoke access"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} functions deploy ${FUNCTION} \
--trigger-http --entry-point process --region ${REGION}  \
--service-account ${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com \
--set-env-vars TOPIC_PROJECT_ID=${PROJECT_ID} \
--memory 256MB --timeout 60s --clear-max-instances \
--runtime python38 --source "Cloud Function" --quiet

${CMD_PREFIX}gcloud --project=${PROJECT_ID} functions add-iam-policy-binding ${FUNCTION} \
--region ${REGION} --member serviceAccount:${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com \
--role roles/cloudfunctions.invoker