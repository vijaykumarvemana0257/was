## Create a bucket

aws s3 mb s3://vijay-encryption

### Create a file and Put Object with encrpytion SS3-S3

echo "Hello World" > hello.txt
aws s3 cp hello.txt  s3://vijay-encryption

### Put Object with encryption of SS3-KMS

aws s3api put-object \
--bucket vijay-encryption \
--key hello.txt \
--body hello.txt \
--server-side-encryption "aws:kms" \
--ssekms-key-id "284d2b60-a5af-464f-b2b0-9d00fd14b934"


### Put Object with SSE-C via aws s3

https://catalog.us-east-1.prod.workshops.aws/workshops/aad9ff1e-b607-45bc-893f-121ea5224f24/en-US/s3/serverside/ssec


openssl rand -out ssec.key 32

aws s3 cp hello.txt s3://encryption-fun-ab-135/hello.txt \
--sse-c AES256 \
--sse-c-key fileb://ssec.key

aws s3 cp s3://encryption-fun-ab-135/hello.txt hello.txt --sse-c AES256 --sse-c-key fileb://ssec.key