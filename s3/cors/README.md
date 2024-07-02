# Create Website 1

## Create a bucket

```sh
aws s3 mb s3://vijay-cors
```

## Change block public access

```sh
aws s3api put-public-access-block \
--bucket vijay-cors \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket vijay-cors --policy file://policy.json
```

## Turn on static website hosting

```sh
aws s3api put-bucket-website --bucket vijay-cors --website-configuration file://website.json
```

## Upload our index.html file and include a resource that would be cross-origin

aws s3 cp index.html s3://vijay-cors

## View the website and see if the index.html is there.




# Create Website 2

```sh
aws s3 mb s3://vijay-cors-1
```

## Change block public access

```sh
aws s3api put-public-access-block \
--bucket vijay-cors-1 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket vijay-cors --policy file://policy-1.json
```

## Turn on static website hosting

```sh
aws s3api put-bucket-website --bucket vijay-cors --website-configuration file://website.json
```

## Upload our javascript file

aws s3 cp hello.js s3://vijay-cors-1


we did nt get any cors issue 

## Create API Gateway with mock response and then test the endpoint



curl -X POST -H "Content-Type: application/json" https://tk7sm2b4oa.execute-api.us-east-2.amazonaws.com/prod/hello


we got the cors issue and then we enabled the cors 
## Set CORS on our bucket

aws s3api put-bucket-cors --bucket vijay-cors --cors-configuration file://cors.json

