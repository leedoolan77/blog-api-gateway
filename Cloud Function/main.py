########## global imports ##########
from google.cloud import pubsub_v1
import json
import os

########## global vars ##########
params = ["function", "event"]
topic_project_id = os.environ.get("TOPIC_PROJECT_ID","")
publisher = pubsub_v1.PublisherClient()

########## classes & functions ##########
def process(request):
    try:
        #parse data
        request_json = request.get_json(silent=True)
        if not request_json:
            request_json = eval(request.data.decode())
        
        #add in queue and event keys
        request_args = request.args
        for p in params:
            request_json[f"x-{p}"] = request_args.get(p,"")

        #publish to pubsub
        payload = json.dumps(request_json)
        payload_byte_string = payload.encode("utf-8")
        topic = f"projects/{topic_project_id}/topics/{request_args['function']}-api-stream"
        publisher.publish(topic, payload_byte_string)

        return("processed", 200)
    except Exception as e:
        print(e)
        return(e, 500)

########## complete ##########
