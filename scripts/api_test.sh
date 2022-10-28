source scripts/common.sh

PROJECT_ID=$1
API_GATEWAY=$2
API_KEY=$3
FUNCTION=$4
TOPIC_ID=$5
CMD_PREFIX=$6

bold "Send test ${FUNCTION} event message."
${CMD_PREFIX}curl -X POST https://${API_GATEWAY}/${FUNCTION}/test-${FUNCTION}-event?key=${API_KEY} \
-H 'Content-Type: application/json' \
-d '{"my_message":"Hello World!"}'
sleep 5

bold "Pull messages from subscription to test receipt of message in pubsub ${TOPIC_ID}"
${CMD_PREFIX}gcloud --project=${PROJECT_ID} pubsub subscriptions pull ${TOPIC_ID}-test-sub
