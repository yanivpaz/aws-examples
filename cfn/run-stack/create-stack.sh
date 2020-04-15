#!/bin/bash
function check_file()
{
IN_FILE=$1
if [ ! -f $IN_FILE ]
then
 echo "$IN_FILE does not exist"
 exit 1
fi
}

function delete_stack_if_requested()
{
if [ "$DELETE_STACK" == "true" ]
then
 echo "deleting stack $STACK_NAME"
 aws cloudformation delete-stack --stack-name $STACK_NAME 
 aws cloudformation wait stack-delete-complete --stack-name  $STACK_NAME
fi
}

function init_vars ()
{
export STACK_DIR=$1
export STACK_NAME=$2

echo "STACK_DIR:$STACK_DIR . STACK_NAME:$STACK_NAME"
if [ -z $STACK_NAME ]
then
 export BUILD_NUMBER="${BUILD_NUMBER:-nobuildnum}"
 export STACK_NAME="${STACK_DIR}-${BUILD_NUMBER}"
 echo "STACK_NAME not provided , using $STACK_NAME "
fi 
export STACK_TEMPLATE="${STACK_DIR}-stack.yaml"
export STACK_PARAMS="${STACK_DIR}-parameters.yaml"

}

function create_stack()
{
check_file ${STACK_DIR}/$STACK_TEMPLATE
check_file generated/$STACK_PARAMS
echo "creating stack $STACK_NAME"
aws cloudformation create-stack   --stack-name $STACK_NAME  \
--template-body file://${STACK_DIR}/${STACK_TEMPLATE} \
--parameters file://generated/${STACK_PARAMS}  \
--role-arn  arn:aws:iam::accounn:role/Qwilt-Cloudformation-ServiceRole 
#--capabilities CAPABILITY_NAMED_IAM 
CFN_STATUS=$?
if [ $CFN_STATUS -ne 0 ]
then
# 255 fail in validation
 echo "failed to run cloudformation : $CFN_STATUS "
 aws cloudformation  describe-stack-events --stack-name $STACK_NAME 
 exit 1
fi

#TODO check status
aws cloudformation wait stack-create-complete --stack-name  $STACK_NAME
aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs"
}

function generateParamfile()
{
echo "generating generated/${STACK_PARAMS}"
rm -f generated/${STACK_PARAMS}
envsubst < ${STACK_DIR}/${STACK_PARAMS} > generated/${STACK_PARAMS}
}

# Main

init_vars "$@"
delete_stack_if_requested
generateParamfile
create_stack
