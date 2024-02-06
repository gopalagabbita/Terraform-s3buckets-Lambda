import csv
import boto3
import os
def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    output_bucket_name = os.environ['s3_bucket_name']
    output_file_name = 'buckets.csv' 

    try:
        with open('/tmp/' + output_file_name, 'w', newline='') as csvfile:
            fieldnames = ['Name', 'CreationDate']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()

            next_token = None
            while True:
                response = s3_client.list_buckets(ContinuationToken=next_token)
                buckets = response['Buckets']
                print (response['Buckets'])
                for bucket in buckets:
                    writer.writerow({'Name': bucket['Name'], 'CreationDate': bucket['CreationDate']})

                next_token = response.get('NextContinuationToken')
                if not next_token:
                    break

        s3_client.upload_file('/tmp/' + output_file_name, output_bucket_name, output_file_name)

        return {
            'statusCode': 200,
            'body': f'Bucket list saved to {output_bucket_name}/{output_file_name}'
        }
    except Exception as e:
        print(f'Error: {e}')
        return {
            'statusCode': 500,
            'body': 'Failed to list buckets and save to CSV'
        }
