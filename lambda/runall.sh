#!/bin/bash

LAMBDA_SRC=ec2_report
scripts/sam_upload_lambda.sh
scripts/sam_package_lambda.sh
scripts/sam_deploy_lambda.sh
