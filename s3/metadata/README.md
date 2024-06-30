## create a bucket

aws s3 mb s3://vijay-metadata

## put object with metdata

aws s3api put-object --bucket vijay-metadata --key hello.txt --body hello.txt --metadata metadata1=test

## get the metadata for the object

aws s3api head-object --bucket vijay-metadata --key hello.txt


    {
        "AcceptRanges": "bytes",
        "LastModified": "2024-06-30T19:12:46+00:00",
        "ContentLength": 11,
        "ETag": "\"7f1e6da34eeb97eea653d76334a76867\"",
        "ContentType": "binary/octet-stream",
        "ServerSideEncryption": "AES256",
        "Metadata": {
            "metadata1": "test"
        }
    }

##clean up

aws s3 rm s3://vijay-metadata  --recursive (removes objects)
aws s3 rb s3://vijay-metadata (removes bucket)