import requests

files = [
    ('file', ('file', open('1.pdf', 'rb'), 'application/octet-stream'))
]
headers = {
    'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9'
}

response = requests.post(
    'https://api.chatpdf.com/v1/sources/add-file', headers=headers, files=files)

if response.status_code == 200:
    print('Source ID:', response.json()['sourceId'])
else:
    print('Status:', response.status_code)
    print('Error:', response.text)
    

import requests

headers = {
    'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9',
    "Content-Type": "application/json",
}

data = {
    'sourceId': "src_zGaagrXZbLcNV3hDaVUyR",
    'messages': [
        {
            'role': "user",
            'content': "display the data that you extracted from the pdf",
        }
    ]
}

response = requests.post(
    'https://api.chatpdf.com/v1/chats/message', headers=headers, json=data)

if response.status_code == 200:
    print('Result:', response.json()['content'])
else:
    print('Status:', response.status_code)
    print('Error:', response.text)
    
    
import requests

headers = {
    'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9',
    "Content-Type": "application/json",
}

data = {
    'sourceId': "src_zGaagrXZbLcNV3hDaVUyR",
    'messages': [
        {
            'role': "user",
            'content': "Write a user-friendly lab analysis report about this lab test, a difinition of this test with title of the test name, then inform the user with their values of the results and what they mean (Interpretation) with additional tips for managing these values to take care of their health?",
        }
    ]
}

response = requests.post(
    'https://api.chatpdf.com/v1/chats/message', headers=headers, json=data)

if response.status_code == 200:
    print('Healtha Report:', response.json()['content'])
else:
    print('Status:', response.status_code)
    print('Error:', response.text)
    
