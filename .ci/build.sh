#!/bin/bash
echo "Getting started with AWS Lambda deployment..."
echo "Installing dependencies..."
apt update -y && apt install -y zip
echo "Zipping deployment package..."
cd ./.build/
zip lambda_artifact.zip lambda_function.py