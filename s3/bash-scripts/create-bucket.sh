#!/usr/bin/env bash

# Check if the bucket name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>"
  exit 1
fi

# Assign the bucket name from the first argument
BUCKET_NAME=$1

# Create the S3 bucket
aws s3api create-bucket --bucket "$BUCKET_NAME" --region us-east-1

# Check if the bucket was created successfully
if [ $? -eq 0 ]; then
  echo "Bucket '$BUCKET_NAME' created successfully."
else
  echo "Failed to create bucket '$BUCKET_NAME'."
  exit 1
fi
