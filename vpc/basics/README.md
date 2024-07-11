
# Create our vpc

aws ec2 create-vpc \
--cidr-block "172.1.0.0/20" \

{
    "Vpc": {
        "CidrBlock": "10.0.0.0/20",
        "DhcpOptionsId": "dopt-0619d2cb3bcc7a41e",
        "State": "pending",
        "VpcId": "vpc-0584dd35d35ca2cf4",
        "OwnerId": "507527568727",
        "InstanceTenancy": "default",
        "Ipv6CidrBlockAssociationSet": [],
        "CidrBlockAssociationSet": [
            {
                "AssociationId": "vpc-cidr-assoc-034ead5002c9f8034",
                "CidrBlock": "10.0.0.0/20",
                "CidrBlockState": {
                    "State": "associated"
                }
            }
        ],
        "IsDefault": false
    }
}


# create a subnet 

aws ec2 create-subnet \
    --vpc-id vpc-0584dd35d35ca2cf4\
    --cidr-block 10.0.0.0/24 


{
    "Subnet": {
        "AvailabilityZone": "us-east-2b",
        "AvailabilityZoneId": "use2-az2",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "10.0.0.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "available",
        "SubnetId": "subnet-04aa12922c49bec57",
        "VpcId": "vpc-0584dd35d35ca2cf4",
        "OwnerId": "507527568727",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "SubnetArn": "arn:aws:ec2:us-east-2:507527568727:subnet/subnet-04aa12922c49bec57",
        "EnableDns64": false,
        "Ipv6Native": false,
        "PrivateDnsNameOptionsOnLaunch": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
        }
    }
}

# create an IGW

aws ec2 create-internet-gateway \                                                                         --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]'

{
    "InternetGateway": {
        "Attachments": [],
        "InternetGatewayId": "igw-0ff87a8575ba928d2",
        "OwnerId": "507527568727",
        "Tags": [
            {
                "Key": "Name",
                "Value": "my-igw"
            }
        ]
    }
}
echo "IGW_ID: $IGW_ID"

# attach an IGW

aws ec2 attach-internet-gateway \
    --internet-gateway-id igw-0ff87a8575ba928d2 \
    --vpc-id vpc-0584dd35d35ca2cf4


# explicty associate subnet

aws ec2 describe-route-tables \
    --filters "Name=vpc-id,Values=vpc-0584dd35d35ca2cf4"

rtb-01d36a17154bcdc5e


aws ec2 associate-route-table --route-table-id rtb-01d36a17154bcdc5e --subnet-id subnet-04aa12922c49bec57



# add a route for our RT to our IGW

aws ec2 create-route \
    --route-table-id rtb-01d36a17154bcdc5e \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id igw-0ff87a8575ba928d2


# create default VPC

aws ec2 create-default-vpc