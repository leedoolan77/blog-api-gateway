source scripts/common.sh

API_GATEWAY=$1
API_KEY=$2
FUNCTION=$3
CMD_PREFIX=$4

bold "${CMD_PREFIX}Send test ${FUNCTION} event message."
EVENT=test-product-event
${CMD_PREFIX}curl -X POST https://${API_GATEWAY}/${FUNCTION}/${EVENT}?key=${API_KEY} \
-H 'Content-Type: application/json' \
-d '{"my_message":"Hello World!"}'


