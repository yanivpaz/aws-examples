#!/bin/bash -e
# define env var ENV_STACKS otherwise all stacks will be retrieved per env_name
export ENVIRONMENT_NAME=${ENVIRONMENT_NAME:-env-name}
export STACK_STATUS=UPDATE_COMPLETE
export TARGET_DATE=`date +%H%M%S`
export TARGET_DIR=~/CFN/backups/${ENVIRONMENT_NAME}/${TARGET_DATE}


if [ $# -eq 1 ]
then
 echo "Using ENV_STACKS :$ENV_STACKS"
 ENV_STACKS=$1
else
 echo "ENV_STACKS is not defined . getting all $ENVIRONMENT_NAME stacks"
 export ENV_STACKS=`aws cloudformation list-stacks  --stack-status-filter ${STACK_STATUS}  --output text | grep -w $ENVIRONMENT_NAME | awk '{print $5}'`
fi

if [[ -z $ENV_STACKS ]]; then
  echo "Couldnt find $ENVIRONMENT_NAME stacks for status : $STACK_STATUS..."
  exit 1
fi


for stack_name in `echo $ENV_STACKS`
do
 aws cloudformation list-stack-resources --stack-name $stack_name --output text | awk -v sname="$stack_name"  '{printf "%-25s %-50s %-25s\n",sname,  $6,$3}'
done
