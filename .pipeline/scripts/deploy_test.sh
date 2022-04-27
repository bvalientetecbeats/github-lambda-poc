#!/bin/bash
echo "Updating Lambda function..."
echo "Installing dependencies..."
apt -qq update -y && apt -qq install -y curl unzip wget tar gzip
AWS_PAGER=''
echo "Configuring AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
aws --version
rm -rf awscliv2.zip terraform_1.1.8_linux_amd64.zip aws
echo "Getting Artifact..."        
echo "Setting up AWS credentials..."    
echo "Configuring AWS-ACCESS-KEY-ID..."
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID_PROD
echo "Configuring AWS-SECRET-ACCESS-KEY..."
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY_PROD
echo "Configuring AWS-REGION-PROD..."
aws configure set default.region $AWS_REGION_PROD
echo "Getting Artifact..."
cd ./git-repo/.build/
aws s3 cp s3://$s3_bucket_name/lambda_artifact.zip lambda_artifact.zip --region $AWS_REGION_PROD
ls -lah && pwd
echo "Setting up AWS credentials..."
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID_TEST
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY_TEST
aws configure set aws_session_token $AWS_SESSION_TOKEN_TEST
aws configure set default.region $AWS_REGION_TEST
echo "Deploying Lambda artifact..."
aws lambda update-function-code --function-name $VAR_LAMBDA_FUNCTION_NAME_TEST --zip-file fileb://lambda_artifact.zip --no-cli-pager
echo "Lambda updated successfully to Test environment!"