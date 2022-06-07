# Alloy Evaluation Function

Lambda function for running Alloy evaluations.

Testing and deployment utilize [AWS SAM](https://aws.amazon.com/serverless/sam/).

## Development

### Set Up

Install dependencies:
- [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- [Docker](https://docs.docker.com/get-docker/)

### Test

AWS credentials must be available, Docker must be running, and BBDB env variables must be set.

Test events are located in [`test/resources/events`](test/resources/events).

```shell
sam build
sam local invoke Function --event test/resources/events/event.json
```

There are also [integrations for IDEs](https://aws.amazon.com/getting-started/tools-sdks/#IDE_and_IDE_Toolkits) available to streamline the testing workflow.

## Dependency Updates Check

```shell
gradle dependencyUpdates
```

### Deploy
```shell
sam build
sam deploy --config-env [env] # "qa" or "prod"
```
