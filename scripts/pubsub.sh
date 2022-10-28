source scripts/common.sh

PROJECT_ID=$1
IAM_ACCOUNT=$2
TOPIC_ID=$3
SETUP_FLAG=$4
CMD_PREFIX=$5

if [[ ${SETUP_FLAG} == "True" ]]; then
    bold "Enable pubsub service"
    ${CMD_PREFIX}gcloud --project=${PROJECT_ID} services enable pubsub.googleapis.com
    sleep 5
    echo
    bold "Create IAM user to post to pubsub topics"
    ${CMD_PREFIX}gcloud --project=${PROJECT_ID} iam service-accounts create ${IAM_ACCOUNT} --description="Used for invoking cloud functions from api"    
fi

echo
bold "Create the ${TOPIC_ID} topic and give user publish rights"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub topics create ${TOPIC_ID}
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub topics add-iam-policy-binding ${TOPIC_ID} \
--member serviceAccount:${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com --role roles/pubsub.publisher
sleep 5

bold "Create a test pull subscription to the pubsub topic ${TOPIC_ID}"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub subscriptions create ${TOPIC_ID}-test-sub --topic ${TOPIC_ID}
