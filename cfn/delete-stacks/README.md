# Delete stack example

simple script to delete stacks based on naming convention .
another option is the list stacks according to query parameter
```
aws cloudformation list-stacks --query "StackSummaries[*].[StackName,StackStatus]" --output text 
```
