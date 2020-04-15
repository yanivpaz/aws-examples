# CFN simple example

Simple demo to create ec2 instance using CFN
see defaults in templates/ec2-instance-stack.yaml

## Create the stack 
### Define env vars 
```
# stack execution parameters
export VERSION_NUMBER=1
export STACK_NAME=my-stack
export ROLE_ARN=<role arn> # example arn:aws:iam::123456:role/my-role

# stack input parametrs
export MY_SSH_KEY=my-keypair
export MY_NETWORK_CID=10.11.12.13/30
export AMI_ID=<ami id>
```

### Run the script
```
./create-stack.sh  template
```	


## Finding Amis 

### Centos
```
aws  ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --output table
```

### Ubuntu
```
 aws ec2 describe-images  --owners aws-marketplace --filters "Name=name,Values=d83d0782-cb94–46d7–8993-f4ce15d1a484" | jq -r '.Images[] | "\(.OwnerId)\t\(.Name)"'
f
```
