source scripts/common.sh

PROJECT_ID=$1
API_GATEWAY=$2
API_KEY=$3
FUNCTION=$4
TOPIC_ID=$5
CMD_PREFIX=$6

bold "${CMD_PREFIX}Create a test pull subscription to the pubsub topic ${TOPIC_ID}"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub subscriptions create ${TOPIC_ID}-test-sub --topic ${TOPIC_ID}

bold "${CMD_PREFIX}Send test ${FUNCTION} event message."
${CMD_PREFIX}curl -X POST https://${API_GATEWAY}/${FUNCTION}/test-${FUNCTION}-event?key=${API_KEY} \
-H 'Content-Type: application/json' \
-d '{"my_message":"Hello World!"}'

bold "${CMD_PREFIX}Pull messages from subscription to test receipt of message in pubsub ${TOPIC_ID}"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub subscriptions pull ${TOPIC_ID}-test-sub

