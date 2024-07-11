## Create NACL

```sh
aws ec2 create-network-acl --vpc-id vpc-015496fdea0adb853
```

{
    "NetworkAcl": {
        "Associations": [],
        "Entries": [
            {
                "CidrBlock": "0.0.0.0/0",
                "Egress": true,
                "IcmpTypeCode": {},
                "PortRange": {},
                "Protocol": "-1",
                "RuleAction": "deny",
                "RuleNumber": 32767
            },
            {
                "CidrBlock": "0.0.0.0/0",
                "Egress": false,
                "IcmpTypeCode": {},
                "PortRange": {},
                "Protocol": "-1",
                "RuleAction": "deny",
                "RuleNumber": 32767
            }
        ],
        "IsDefault": false,
        "NetworkAclId": "acl-0135f7c67f70df49d",
        "Tags": [],
        "VpcId": "vpc-015496fdea0adb853",
        "OwnerId": "507527568727"
    },
    "ClientToken": "9725de8c-9732-4a75-9daa-f772c9e56a12"
}

## Add entry

```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-02def3052778d5ce2 \
--ingress \
--rule-number 90 \
--protocol -1 \
--port-range From=0,To=65535 \
--cidr-block 174.5.108.3/32 \
--rule-action deny
```


## Get AMI for Amazon Linux 2

Gab the latest AML2 AMI
```sh
aws ec2 describe-images \
--owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
--query "Images[?starts_with(Name, 'amzn2')]|sort_by(@, &CreationDate)[-1].ImageId" \
--region ca-central-1 \
 --output text
```