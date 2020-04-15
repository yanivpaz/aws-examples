#!/bin/bash -e
# define env var ENV_STACKS otherwise all stacks will be retrieved per env_name
export ENVIRONMENT_NAME=${ENVIRONMENT_NAME}
export STACK_STATUS=UPDATE_COMPLETE
export TARGET_DATE=`date +%H%M%S`
export TARGET_DIR=~/CFN/backups/${ENVIRONMENT_NAME}/${TARGET_DATE}



if [[ -z $ENVIRONMENT_NAME ]]
then
  echo "Please specify env name (ENVIRONMENT_NAME)"
  exit 1
fi

if [ $# -eq 1 ]
then
 echo "Using ENV_STACKS :$ENV_STACKS"
 ENV_STACKS=$1
else
 echo "ENV_STACKS is not defined . getting all $ENVIRONMENT_NAME stacks"
 export ENV_STACKS=`aws cloudformation list-stacks  --stack-status-filter ${STACK_STATUS}  --output text | grep -w $ENVIRONMENT_NAME | awk '{print $5}'`
fi

echo "script env vars:$ENVIRONMENT_NAME $ENV_STACKS"
mkdir -p ${TARGET_DIR}/cfn_templates

if [ ! -d $TARGET_DIR ]
then
 echo "Creating $TARGET_DIR "
 mkdir -p $TARGET_DIR
fi


if [[ -z $ENV_STACKS ]]; then
  echo "Couldnt find $ENVIRONMENT_NAME stacks for status : $STACK_STATUS..."
  exit 1
fi


echo "Target dir is $TARGET_DIR"
for stack_name in `echo $ENV_STACKS`
do
echo "exporting $stack_name"
 aws cloudformation get-template --stack-name $stack_name --template-stage Original  | jq .TemplateBody  > ${TARGET_DIR}/cfn_templates/${stack_name}.template
done