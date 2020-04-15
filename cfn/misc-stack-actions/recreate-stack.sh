#!/bin/bash

if [ -z  $STACK_NAME ]
then
 echo "STACK_NAME is not defined"
 exit 1 
fi

export STACK_TEMPLATE=/tmp/${STACK_NAME}.template
echo "exporting  stack $STACK_NAME to $STACK_TEMPLATE"
aws cloudformation get-template --stack-name $STACK_NAME --template-stage Original  | jq .TemplateBody > $STACK_TEMPLATE

echo "deleting  stack $STACK_NAME"
aws cloudformation delete-stack --stack-name $STACK_NAME
aws cloudformation wait  stack-delete-complete  --stack-name $STACK_NAME

echo "creating stack $STACK_NAME"
aws cloudformation create-stack   --stack-name $STACK_NAME  --template-body file://$STACK_TEMPLATE  --on-failure DO_NOTHING
aws cloudformation wait stack-create-complete --stack-name  $STACK_NAME
rm -f $STACK_TEMPLATE




