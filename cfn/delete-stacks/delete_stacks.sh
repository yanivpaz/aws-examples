#!/bin/bash

# Demo script to delete multiple k8s stacks
function check_status()
{
ERROR_MESSAGE=$1
STATUS=$2
 if [ $STATUS -ne 0 ]
 then
  echo "$ERROR_MESSAGE"
  exit 1
 fi

}

if [ -z $EKS_CLUSTER_NAME ]
then 
 echo "EKS_CLUSTER_NAME is not defined"
 exit 1 
fi


# assuming stack names is $EKS_CLUSTER_NAME-masters,$EKS_CLUSTER_NAME-nodegroup,$EKS_CLUSTER_NAME-vpc
for CFN_STACK in `echo masters nodegroup vpc` 
do
 STACK_NAME=$EKS_CLUSTER_NAME-$CFN_STACK
 echo "Deleting stack $STACK_NAME"
 aws cloudformation delete-stack --stack-name $STACK_NAME
 status=$?
 check_status "Failed to delete $STACK_NAME" $status
 aws cloudformation wait  stack-delete-complete  --stack-name $STACK_NAME
 status=$?
 check_status "Failed to wait for stack delete" $status 
done
