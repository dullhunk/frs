import json
#import urllib2
from urllib.request import urlopen
from pprint import pprint

#import urllib.request
#with urllib.request.urlopen('http://python.org/') as response:
#   html = response.read()

#print(html)

#awards Kilburn entry scholarship (60 students per year)
#alumni questions
# mentoring change to orientation (not training)

# Get the dataset
url = 'http://archive.org/wayback/available?url=https://royalsociety.org/people/steve-brown-11152'
response = urlopen(url)

# parsing http response in python
# http://stackoverflow.com/questions/23049767/parsing-http-response-in-python
# Convert bytes to string type and string type to dict
string = response.read().decode('utf-8')
json_obj = json.loads(string)

print(json_obj['archived_snapshots'])

#brown_load = urlopen('')

#brown_thing = json.load(brown_load.decode('utf-8'))
#fred = brown_thing.decode('utf-8')
# TypeError: the JSON object must be str, not 'bytes'

#print(brown_load)

#response = urlopen('http://archive.org/wayback/available?url=https://royalsociety.org/people/steve-brown-11152')
#html = response.read().decode("utf8")

#print(html)


#browns_obj = json.loads(brown_load)
# TypeError: the JSON object must be str, not 'HTTPResponse'

#output = brown_obj.decode('ascii')

#a_string = '深入 Python'
#by = a_string.encode('utf-8')
#print(by)



#print('hello world')

#birney_load = urllib2.urlopen('http://archive.org/wayback/available?url=https://royalsociety.org/people/ewan-birney-11091')
#birney_obj = json.load(birney)

#pprint(brown_obj)

#pprint(brown_load)

#archive_ResultNo = '{"archived_snapshots":{}}'

# If URL is archived e.g.
# http://archive.org/wayback/available?url=https://royalsociety.org/people/ewan-birney-11091


# archive_ResultYes  = '{"archived_snapshots":{"closest":{"available":true,"url":"http://web.archive.org/web/20151116210056/https://royalsociety.org/people/ewan-birney-11091/","timestamp":"20151116210056","status":"200"}}}'

#parsed_json = json.loads(json_string)

#parsed_jsonYES = json.loads(archive_ResultYes)


#parsed_jsonNO = json.loads(archive_ResultNo)

#print(parsed_json['first_name'])

#print('YES result is')
#print(parsed_jsonYES['archived_snapshots'])


#print('NO result is')
#print(parsed_jsonNO['archived_snapshots'])
