#!/usr/bin/env python3

import boto3
import argparse
import os
import json


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Remove terminated nodes from puppetmaster',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('sqs_queue_url', type=str, help='SNS queue url')
    parser.add_argument('region', type=str, help='AWS region')

    args = parser.parse_args()

    # Create SQS client
    sqs = boto3.client('sqs', region_name=args.region)

    # Receive message from SQS queue
    response = sqs.receive_message(
        QueueUrl=args.sqs_queue_url,
        AttributeNames=[
            'SentTimestamp'
        ],
        MaxNumberOfMessages=1,
        MessageAttributeNames=[
            'All'
        ],
        VisibilityTimeout=0,
        WaitTimeSeconds=0
    )

    try:
        message = response['Messages'][0]
        receipt_handle = message['ReceiptHandle']

        body = json.loads(message['Body'])
        instanceid = body['detail']['instance-id']


        os.system(f"/opt/puppetlabs/bin/puppet node deactivate {instanceid}.tc.local")
        os.system(f"/opt/puppetlabs/bin/puppet node clean {instanceid}.tc.local")

        # Delete received message from queue
        sqs.delete_message(
            QueueUrl=args.sqs_queue_url,
            ReceiptHandle=receipt_handle
        )
        print('Received and deleted message: %s' % instanceid)
    except KeyError:
        pass


