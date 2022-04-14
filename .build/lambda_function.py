import urllib3

def lambda_handler(event, context):
    print('Hello, POC')
    print()
    http = urllib3.PoolManager()
    r = http.request('GET','https://6a3fn4ovdc.execute-api.us-west-2.amazonaws.com/v2/platforms')
    print(r.data)