## Create an s3 bucket

aws s3 mb s3://vijay-replica-source
aws s3 mb s3://vijay-replica-dest --region us-east-1


## Turn on S3 Versioning for both buckets

aws s3api put-bucket-versioning --bucket vijay-replica-source --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket vijay-replica-dest --versioning-configuration Status=Enabled

# Create a Role and Policy for S3 Replication


aws iam create-policy \
    --policy-name s3-replication \
    --policy-document file://policy.json

    
aws iam create-role \
    --role-name s3-replication \
    --assume-role-policy-document file://trust.json


aws iam attach-role-policy \
    --policy-arn arn:aws:iam::507527568727:policy/s3-replication \
    --role-name s3-replication

## Turn on Replication

aws s3api put-bucket-replication \
    --bucket vijay-replica-source \
    --replication-configuration file://replication.json


# create a file and upload to our bucket

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://vijay-replica-source/hello.txt

# check dest bucket to see if replication worked

aws s3 ls s3://replication-fun-us-east-ab-4535

# Cleanup

> empty and delete the buckets in the console its the easiest way to clear all versions