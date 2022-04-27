#!/bin/bash
echo "Getting started with AWS Lambda deployment..."
echo "Installing dependencies..."
apt -qq update -y && apt -qq install -y zip
echo "Zipping deployment package..."
cd ./git-repo/.build/
zip lambda_artifact.zip lambda_function.py