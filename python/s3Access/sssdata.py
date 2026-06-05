import boto3
from load_dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()
# Get AWS credentials from environment variables
s3_client = boto3.client('s3',
                         region_name='ap-south-1',
    aws_access_key_id=os.environ['aws_access_key_id'],
    aws_secret_access_key=os.environ['aws_secret_access_key']
)

# list all buckets
response = s3_client.list_buckets()
for bucket in response['Buckets']:
    print(f"Bucket Name: {bucket['Name']}, Creation Date: {bucket['CreationDate']}")
    
# delete bucket
# response = s3_client.delete_bucket(Bucket='rahuldemo2026')
# print(response)