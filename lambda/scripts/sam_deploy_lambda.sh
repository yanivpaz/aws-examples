#!/bin/bash
export TEMPLATE_FILE=sam_template.yaml
export TEMPLATE_FILE=sam_template_package_output.yaml

aws cloudformation deploy \
 --template-file $TEMPLATE_FILE \
 --stack-name devops-sam \
 --capabilities CAPABILITY_IAM \
 --parameter-overrides IdentityNameParameter=yaniv
