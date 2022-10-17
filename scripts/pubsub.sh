source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
TOPIC_ID=$3
CMD_PREFIX=$4

bold "${CMD_PREFIX}Enable pubsub service"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable pubsub.googleapis.com
echo
bold "${CMD_PREFIX}Create IAM user to post to pubsub topics"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} iam service-accounts create ${IAM_ACCOUNT} --description="Used for invoking cloud functions from api"
echo
bold "${CMD_PREFIX}Create the ${TOPIC_ID} topic and give user publish rights"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub topics create ${TOPIC_ID}
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub topics add-iam-policy-binding ${TOPIC_ID} \
--member serviceAccount:${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com --role roles/pubsub.publisher
