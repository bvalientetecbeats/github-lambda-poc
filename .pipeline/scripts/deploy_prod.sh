#!/bin/bash
echo "Updating Lambda function..."
echo "Installing dependencies..."
apt update -y
apt install -y curl unzip wget tar gzip
AWS_PAGER=''
echo "Configuring AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
aws --version
echo "Setting up AWS credentials..."        
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID_PROD
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY_PROD
aws configure set default.region $AWS_DEFAULT_REGION_PROD
rm -rf awscliv2.zip terraform_1.1.8_linux_amd64.zip aws
aws s3 ls
echo "Deploying Lambda artifact..."
cd ./.build/
aws lambda update-function-code --function-name $VAR_LAMBDA_FUNCTION_NAME_PROD --zip-file fileb://lambda_artifact.zip --no-cli-pager --region $AWS_DEFAULT_REGION_PROD
echo "Lambda updated successfully to Production environment!"