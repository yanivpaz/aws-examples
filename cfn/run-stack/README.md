# CFN simple example

Simple demo to create ec2 instance using CFN

## Create the stack 

```
export AMI_ID=<ami id>
export BUILD_NUMBER=
export STACK_NAME=my-stack
export MY_SSH_KEY=my-keypair
export MY_NETWORK_CID=10.11.12.13/30

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
