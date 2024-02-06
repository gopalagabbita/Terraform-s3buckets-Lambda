import json
import boto3
import csv
def write_column(writer, data):
     for element in data:
        writer.writerow([element])
def lambda_handler(event, context):
    column_data = ["buckets"]
    buckets = []
    client = boto3.client('s3')
    response = client.list_buckets()
    for value in response['Buckets']:
        buckets.append(value['Name'])
    with open('/tmp/buckets.csv', 'w', newline = '') as file:
        writer = csv.writer(file)
        write_column(writer,buckets)
    
    s3 = boto3.resource('s3')
    dest_bucket = s3.Bucket('ramdevops')
    dest_bucket.upload_file('/tmp/buckets.csv', 'krishna/buckets.csv')