cd src
zip mytest.zip *
aws s3 cp ./mytest.zip  s3://my-demo-devops-helper-bucket/lambda/mytest/
rm mytest.zip
