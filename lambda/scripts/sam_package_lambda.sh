#!/bin/bash
export TEMPLATE_FILE=sam_template_package.yaml

aws cloudformation package \
 --template-file $TEMPLATE_FILE \
 --s3-bucket my-demo-devops-helper-bucket \
 --s3-prefix lambda/mytest/ \
 --output-template-file sam_template_package_output.yaml


# --parameter-overrides IdentityNameParameter=yaniv \
