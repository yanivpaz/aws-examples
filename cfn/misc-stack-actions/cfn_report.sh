#!/bin/bash
export AWS_DEFAULT_REGION=eu-central-1
echo  "***********************************"
echo  "Checking region $AWS_DEFAULT_REGION"
echo  "***********************************"
aws cloudformation list-stacks --query "StackSummaries[*].[StackName,StackStatus]" --output text | sort | grep -v DELETE_COMPLETE | grep -v tc-eu-

export AWS_DEFAULT_REGION=us-west-2
echo  "***********************************"
echo  "Checking region $AWS_DEFAULT_REGION"
echo  "***********************************"
aws cloudformation list-stacks --query "StackSummaries[*].[StackName,StackStatus]" --output text | sort | grep -v DELETE_COMPLETE | grep -v "^prod" | sort
