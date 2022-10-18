# blog-api-gateway

Commands to be run in this order:

- make auth - to authenticate with Google Cloud
- make project - to make your API project and attach to your billing account
- make pubsub - to build the PubSub topics
- make function - to build the Cloud Function
- make api_create - to build the API, API Config and API Gateway
- make api_describe - to get info about the API and API Gateway i.e. managed service and host names
- make api_key - to enable the managed service and generate / associate an API key

And you can test using:

- make api_test - to creat a PubSub subscription to our topics, send a test essage, and test receipt

