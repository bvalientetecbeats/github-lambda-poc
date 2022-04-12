import pandas as pd
import requests

def lambda_handler(event, context):
    d = {'col1': [1,2], 'col2': [3,4]}
    df = pd.DataFrame(data=d)
    r = requests.get('https://6a3fn4ovdc.execute-api.us-west-2.amazonaws.com/v2/platforms')
    print('Hello POC!')
    print(df)
    print('HTTP Request:')
    print(r.text)