## create bucket
aws s3 mb s3://vijay-objectlock-fun
## turn on ersiononing

aws s3api put-bucket-versioning --bucket vijay-objectlock-fun --versioning-configuration Status=Enabled
## objet lock
aws s3api put-object-lock-configuration \
    --bucket vijay-objectlock-fun\
    --object-lock-configuration '{ "ObjectLockEnabled": "Enabled", "Rule": { "DefaultRetention": { "Mode": "GOVERNANCE", "Days": 1 }}}'

## New file and upload

echo "This is the gov2" > gov.txt
aws s3 cp gov.txt s3://vijay-objectlock-fun

## delete the file

aws s3 rm s3://object-lock-fun-ab-1241/gov.txt

## delete the versioned file

aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "gov.txt" --version-id="SpI0i1NxLl9oRvJFzHK4BrCpltxYmIPs" --bypass-governance-retention 


