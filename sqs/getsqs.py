import boto3
import json

queue_name = 'DLSQS2'
max_queue_messages = 10
message_bodies = []
sqs = boto3.resource('sqs')
queue = sqs.get_queue_by_name(QueueName=queue_name)
while True:
    messages_to_delete = []
    for message in queue.receive_messages(
            MaxNumberOfMessages=max_queue_messages):
        # process message body
        body = json.loads(message.body)
        print (body)

