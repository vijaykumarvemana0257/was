#!/usr/bin/env bash

echo "== deploy rds"

STACK_NAME="rds-basic"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html
aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-execute-changeset \
--parameter-overrides VpcId="vpc-0edf1594968b9e64d" WebServerSGGroupId="sg-0d171ed2b9c5b4212" RdsSecretArn="arn:aws:secretsmanager:us-east-2:507527568727:secret:MyRdsPassword-YZqkYK" Username="vijay" Subnets="subnet-06542ba48cddf0634,subnet-034956d23fc4c225a,subnet-0590da307624ad3b1" \
--region us-east-2 \
--stack-name $STACK_NAME



postgresql://postgres:mypassword@rds-basic-rdsinstance-ewhkdoacrxzd.cbk8g6s064cm.us-east-2.rds.amazonaws.com:5432/mydatabase