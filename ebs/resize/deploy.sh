#!/usr/bin/env bash

echo "== deploy secrets manager stuff"

STACK_NAME="aws-sm-basic"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html
aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-execute-changeset \
--region us-east-2 \
--stack-name $STACK_NAME