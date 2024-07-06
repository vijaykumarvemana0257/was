# create a bucket without versioning
aws s3 mb s3://vijay-version-fun

# create a unversioned file
echo "Hello World" > myfile.txt

# copy the unversioned file to s3
aws s3 cp myfile.txt s3://vijay-version-fun

# show the contents of the s3 bucket notice that s3 ls does not show versioning information
aws s3 ls s3://vijay-version-fun

## Get a more detailed listing of the bucket, noticed it does not show versioning information
 aws s3api list-objects-v2 --bucket vijay-version-fun

# get object versions and see what happens on an unversioned object
aws s3api list-object-versions --bucket vijay-version-fun --prefix myfile.txt
#   make note that versionid is null
#   "VersionId": "null"

# turn on versioniong for our s3 bucket
aws s3api put-bucket-versioning --bucket vijay-version-fun --versioning-configuration Status=Enabled

# confirm bucket versioning is turned on via the cli
aws s3api get-bucket-versioning --bucket vijay-version-fun
# {
#    "Status": "Enabled"
# }


# check previous file if it has a version
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt
# noticing existing object the version is is still null
# VersionId": "null"

# lets update the file in order to apply versioning
echo "Hello Mars" > myfile.txt
aws s3 cp myfile.txt s3://vijay-version-fun

# check if file now has a version
aws s3api list-object-versions --bucket vijay-version-fun --prefix myfile.txt
#  it should have two versions:
#  "VersionId": "F89YK40h2v1h2.tlofAAwPagQvKD69gq",
#  "VersionId": "null",

# update it again
echo "Hello Jupiter" > myfile.txt
aws s3 cp myfile.txt s3://vijay-version-fun
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt --query Versions[].VersionId --output table

# lets see the contents of the latest file
# note that we cannot use s3 cp to get specific versions of a file
# because its a high level S3 api
aws s3 cp s3://vijay-version-fun/myfile.txt - | cat


# We can print out the contents of the s3 file and get the versioning with s3api get-object
aws s3api get-object --bucket vijay-version-fun --version-id F89YK40h2v1h2.tlofAAwPagQvKD69gq --key myfile.txt /dev/stdout | cat


# lets delete an object without specifying the version id
aws s3api delete-object --bucket vijay-version-fun --key myfile.txt
# {
#     "DeleteMarker": true,
#     "VersionId": "CAW1vbzBNxhlROMI1.cV9i6Y.o2TiDO_"
# }

# lets attempt to fetch the object
aws s3api get-object --bucket vijya-version-fun
# this will return a 403 because the file is deleted.

# get all object verions
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt 
# make note there is a delete marker
# make note that all versions are still there

# lets see if we can get the previous version which we technically deleted
aws s3api get-object --bucket vijay-version-fun --version-id 2_1ljEQ.EeNvA5Bvd3suXI3E.DBmTioN --key myfile.txt /dev/stdout | cat

# lets bring back the last version by downloading it and reuploading it aka copy it back
aws s3api get-object --bucket vijay-version-fun --version-id 2_1ljEQ.EeNvA5Bvd3suXI3E.DBmTioN --key myfile.txt myfile.txt
aws s3api put-object --bucket vijay-version-fun --key myfile.txt

# lets check the versions again
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt 

# Create an MFA Virtual Device under your user. We'll turn on MFA
# you need attach MFA to root user
# you will need to generate our root credentials
# you cannot use cloud shell

# https://repost.aws/knowledge-center/s3-bucket-mfa-delete
aws s3api put-bucket-versioning --bucket vijay-version-fun --versioning-configuration MFADelete=Enabled,Status=Enabled --mfa "arn:aws:iam::507527568727:mfa/authy 440726"

# lets try and delete our object from our non root user
aws s3api delete-object --bucket vijay-version-fun --key myfile.txt
# this will create a delete marker
# it doesn't actually delete objects so its not going to trigger MFA Delete


# lets specify a version to permenatly delete
aws s3api delete-object --bucket vijay-version-fun --key myfile.txt --version-id qXzVH_TKEexOantlib4jbhq9wp1VXNXM --mfa "arn:aws:iam::507527568727:mfa/authy 606973"
# notice it removes the version permenatly

## turn off MFA and versioning
aws s3api put-bucket-versioning --bucket aws-s3-versioning-ab5345 --versioning-configuration MFADelete=Disabled,Status=Suspended --mfa "arn:aws:iam::982383527471:mfa/Authy 785772"


# lets look at our object versions
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt 

# lets push a update objected on suspended versioning
echo "Hello Neptune" > myfile.txt
aws s3 cp myfile.txt s3://aws-s3-versioning-ab5345
aws s3api list-object-versions --bucket aws-s3-versioning-ab5345 --prefix myfile.txt