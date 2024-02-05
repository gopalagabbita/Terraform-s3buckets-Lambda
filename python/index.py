import json
import csv
import boto3

def lambda_handler(event, context):
    buckets = []
    client = boto3.client('s3')
    response = client.list_buckets()
    for value in response['Buckets']:
        buckets.append(value['Name'])
    with open('/tmp/buckets.csv', 'w', newline = '') as file:
        writer = csv.writer(file)
        writer.writerow(buckets)
    
    s3 = boto3.resource('s3')
    dest_bucket = s3.Bucket('ggdevops-us-east-1')
    dest_bucket.upload_file('/tmp/buckets.csv', 'test/buckets.csv')