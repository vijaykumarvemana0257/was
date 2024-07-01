## create a bucket 

aws s3 mb s3://vijay-bucket-policy


## assigh the policy 
aws s3api put-bucket-policy --bucket vijay-bucket-policy --policy file://policy.json

## put the object from other account

touch bootcamp.txt
aws s3 cp bootcamp.txt s3://vijay-bucket-policy
aws s3 ls s3://vijay-bucket-policy

## clean up 

aws s3 rm s3://vijay-bucket-policy/bootcamp.txt
aws s3 rb s3://vijay-bucket-policy