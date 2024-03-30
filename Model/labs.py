import requests

files = [
    ('file', ('file', open('1.pdf', 'rb'), 'application/octet-stream'))
]
headers = {
    'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9'
}

response = requests.post(
    'https://api.chatpdf.com/v1/sources/add-file', headers=headers, files=files)


headers = {
    'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9',
    "Content-Type": "application/json",
}

data = {
    'sourceId': "src_zGaagrXZbLcNV3hDaVUyR",
    'messages': [
        {
            'role': "user",
            'content': "Write a user-friendly lab analysis report about this lab test in this formats, "
                       "in this report write"
                       "start with Dear (patient name from the report), We hope this report finds you in good health. "
                       "We have conducted a comprehensive lab analysis to assess your overall health, "
                       "with a specific focus on your important values levels. "
                       "Below, you will find the results of the analysis along with some tips for managing your health."
                       "1. Test overall difinition 2. Interpretations explained about the user each important values result"
                       "3. Medical advices and tips for managing these values to take care of their health"
                       "after the final warm regards write (Healtha team)"
        }
    ]
}

response = requests.post(
    'https://api.chatpdf.com/v1/chats/message', headers=headers, json=data)

if response.status_code == 200:
    print('Your Healtha Report\n' )
    print(response.json()['content'])
else:
    print('Status:', response.status_code)
    print('Error:', response.text)

