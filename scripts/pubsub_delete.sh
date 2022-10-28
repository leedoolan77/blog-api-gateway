source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
TOPIC_ID=$3
SETUP_FLAG=$4
CMD_PREFIX=$5

echo
bold "Delete test pull subscription to the pubsub topic ${TOPIC_ID}"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub subscriptions delete ${TOPIC_ID}-test-sub
sleep 5

bold "Delete the ${TOPIC_ID} topic"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub topics delete ${TOPIC_ID}
sleep 5

bold "Delete IAM user - may error if other dependencies"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} iam service-accounts delete ${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com
