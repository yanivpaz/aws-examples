#!/bin/bash


COMMON_PARAMS="--stack-name my-stack --change-set-name network-upgrade"
aws cloudformation create-change-set  --template-body file://template.new.json2 $COMMON_PARAMS 
aws cloudformation wait change-set-create-complete $COMMON_PARAMS    
aws cloudformation describe-change-set $COMMON_PARAMS \
|  jq -r '( .Changes[].ResourceChange | [ .Action,.Replacement,.ResourceType,.LogicalResourceId,.PhysicalResourceId ]) | @csv'

aws cloudformation delete-change-set $COMMON_PARAMS


# Todo 
#|  jq -r '["Action","Replace","Type","LogicalID","PhysicalID"], ["------","------","------","------","------"], ( .Changes[].ResourceChange | [ .Action,.Replacement,.ResourceType,.LogicalResourceId,.PhysicalResourceId ]) | @csv'
