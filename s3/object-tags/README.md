## Create a bucket

aws s3 mb s3://vijay-objecttag

## Upload file

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://vijay-objecttag

## Apply Object Tagging

aws s3api put-object-tagging \
    --bucket vijay-objecttag\
    --key hello.txt \
    --tagging '{"TagSet": [{ "Key": "hello", "Value": "world" }]}'


##  Cleanup

aws s3 rm s3://vijay-objecttag/hello.txt
aws s3 rb s3://vijay-objecttag