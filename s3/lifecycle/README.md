## Create a new bucket

aws s3 mb s3://vijay-lifecycle

# Create lifecycle policy configuration

aws s3api put-bucket-lifecycle-configuration --bucket vijay-lifecycle --lifecycle-configuration file://lifecycle.json

## Cleanup

aws s3 rb s3://vijay-lifecycle