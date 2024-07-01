## create a bucket 

aws s3api create-bucket --bucket vijay-acls-fun --region us-east-1

## edit public access of the bucket 

aws s3api put-public-access-block \
    --bucket vijay-acls-fun \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"

## check the public access 

aws s3api get-public-access-block --bucket vijay-acls-fun

## chnaeg the bucket owner ship control 

aws s3api put-bucket-ownership-controls \
    --bucket vijay-acls-fun \
    --ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"


## Give permsiion via ACL

aws s3api put-bucket-acl \
--bucket vijay-acls-fun \
--access-control-policy file:///workspace/was/s3/acls/policy.json


## access the bucket from another account 

touch bootcamp.txt
aws s3 cp bootcamp.txt s3://acl-example-ab-5235
aws s3 ls s3://vijay-acls-fun

## clean up
aws s3 rm s3://vijay-acls-fun/hello.txt
aws s3 rb s3://vijay-acls-fun