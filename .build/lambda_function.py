import requests

def lambda_handler(event, context):
    r = requests.get('https://6a3fn4ovdc.execute-api.us-west-2.amazonaws.com/v2/platforms')
    print('Hello POC!')
    print('HTTP Request:')
    print(r.text)