#!/bin/sh
echo "Updating Lambda function..."
echo "Installing dependencies..."
apt -qq update -y && apt -qq install -y curl unzip wget tar gzip
echo "Configuring AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
aws --version
echo "Setting up AWS credentials..."        
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID_DEV
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY_DEV
aws configure set aws_session_token $AWS_SESSION_TOKEN_DEV
aws configure set default.region $AWS_REGION_DEV
rm -rf awscliv2.zip terraform_1.1.8_linux_amd64.zip aws
aws s3 ls
echo "Deploying Lambda artifact..."
cd ./git-repo/.build/
aws s3 cp s3://$s3_bucket_name/lambda_artifact.zip lambda_artifact.zip --region $AWS_REGION_DEV
aws lambda update-function-code --function-name $VAR_LAMBDA_FUNCTION_NAME_DEV --zip-file fileb://lambda_artifact.zip --no-cli-pager
echo "Lambda updated successfully to Development environment!"