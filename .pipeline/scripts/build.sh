#!/bin/bash
echo "Getting started with AWS Lambda deployment..."
echo "Installing dependencies..."
apt -qq update -y && apt -qq install -y zip unzip curl
echo "Zipping deployment package..."
cd ./git-repo/.build/
zip lambda_artifact.zip lambda_function.py
echo "Setting up AWS environment..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
aws --version
echo "Setting up AWS credentials..."        
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID_PROD
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY_PROD
aws configure set default.region $AWS_DEFAULT_REGION_PROD
echo "Uploading Lambda Artifact to S3..."
cp lambda_artifact.zip s3://$s3_bucket_name/lambda_artifact.zip