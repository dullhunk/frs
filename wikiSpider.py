from lxml import html
import requests
import collections
import csv
import sys
import time
import json
from selenium import webdriver
from time import sleep

MAX_FAIL_COUNT = 5
reload(sys)
sys.setdefaultencoding('utf8')

url = "https://en.wikipedia.org/wiki/Fellow_of_the_Royal_Society"
response = requests.get(url)
tree = html.fromstring(response.text)

year_urls = tree.xpath('//td//li/a/@href')
year_urls = year_urls[:231]
year_fail_urls = []

# catch all fellow names
fail_count = 0
fellow_names = []
year_names = []

home_url = "https://en.wikipedia.org"
for year_url in year_urls:
    print year_url
    year_name = {}
    fellow_names_tmp = []
    while fail_count < MAX_FAIL_COUNT:
        try:
            res = requests.get(home_url + year_url, timeout = 30)
            year_tree = html.fromstring(res.text)
            fellow_names_tmp = fellow_names_tmp + year_tree.xpath('//*[@id="mw-content-text"]/ul/li/a/text()')
            fellow_names_tmp = fellow_names_tmp + year_tree.xpath('//*[@id="mw-content-text"]/ol/li/a/text()')
            fellow_names_tmp = fellow_names_tmp + year_tree.xpath('//*[@id="mw-content-text"]/div[1]/ul/li/a/text()')
            fellow_names_tmp = fellow_names_tmp + year_tree.xpath('//*[@id="mw-content-text"]/div[1]/ol/li/a/text()')   #2001

            #handle 1819 , no url and url is different
            l = len(year_tree.xpath('//*[@id="mw-content-text"]/div[2]/ol/li'))
            f_nameslist = []
            f_nameslist = year_tree.xpath('//*[@id="mw-content-text"]/div[2]/ol/li/a/text()')
            for i in range(l):
                if len(year_tree.xpath('//*[@id="mw-content-text"]/div[2]/ol/li[%s]/a/text()' % str(i))) == 0:
                    f_nameslist = f_nameslist + year_tree.xpath('//*[@id="mw-content-text"]/div[2]/ol/li[%s]/text()' % str(i))
            fellow_names_tmp = fellow_names_tmp + f_nameslist




            if len(year_tree.xpath('//*[@id="mw-content-text"]/ul/li/a/text()')) == 0:
                print "no 1"
            if len(year_tree.xpath('//*[@id="mw-content-text"]/ol/li/a/text()')) ==0 :
                print "no 2"
            if len(year_tree.xpath('//*[@id="mw-content-text"]/div[1]/ul/li/a/text()')) == 0:
                print "no 3"
            if len(year_tree.xpath('//*[@id="mw-content-text"]/div[1]/ol/li/a/text()')) == 0:
                print "no 4"

            fellow_names = fellow_names + fellow_names_tmp
            for name in fellow_names_tmp:
                year_name['name'] = name
                year_name['year'] = year_url[-4:]
                year_names.append(year_name)
                year_name = {}
            break
        except:
            fail_count = fail_count + 1

    if fail_count == MAX_FAIL_COUNT:
        print "fail:", year_url, fail_count
        year_fail_urls.append(year_url)
    fail_count = 0

year_name_json = json.dumps(year_names)
f = file("year_name.json", "wb")
f.write(year_name_json)
f.close()

print len(fellow_names)


# search fellow names
head_url = 'https://www.scopus.com'
search_url = 'https://www.scopus.com/results/authorNamesList.uri?origin=searchauthorlookup&src=al&st1=%s&st2=%s&exactSearch=on'
session = requests.Session()
session.post('https://www.scopus.com/customer/authenticate.uri', {'username':'yyrunzzz@gmail.com', 'password':'463672542',})
name_index_dict = collections.OrderedDict()
result = []

fail_count = 0
fail_fellow_names = []
driver = webdriver.Firefox()
for i, year_name in enumerate(year_names):
    fellow_name = year_name['name']
    fellow_name_list = fellow_name.split()
    if len(fellow_name_list) > 1:
        for name_num in range(len(fellow_name_list) - 1):
            tmp_url = search_url % (fellow_name_list[name_num + 1], fellow_name_list[name_num])
            success_search = False
            while fail_count < MAX_FAIL_COUNT:
                try:
                    author_url = ""
                    res = session.get(tmp_url, timeout = 60)
                    res_tree = html.fromstring(res.text)
                    if len(res_tree.xpath('//*[@id="resultDataRow1"]/div[2]/div[1]/span/a/@href')) != 0:
                        author_url = head_url + res_tree.xpath('//*[@id="resultDataRow1"]/div[2]/div[1]/span/a/@href')[0]
                        print author_url
                        driver.get(author_url)
                        sleep(3)
                        #author_res = session.get(author_url, timeout = 60)
                        #author_tree = html.fromstring(author_res.text)
                        #author_index = author_tree.xpath('//*[@id="authLeftList"]/li[3]/div[2]/span[1]/text()')
                        #author_citations = author_tree.xpath('//*[@id="totalCiteCount"]/text()')
                        year_names[i]['index'] = driver.find_element_by_xpath('//*[@id="authLeftList"]/li[3]/div[2]/span[1]').text
                        year_names[i]['citation'] = driver.find_element_by_xpath('//*[@id="totalCiteCount"]').text
                        success_search = True
                    else:
                        year_names[i]['index'] = None
                        year_names[i]['citation'] = None
                        fail_fellow_names.append(fellow_name)
                        print "search fail:", fellow_name, tmp_url

                    break
                except:
                    fail_count = fail_count + 1
                    print fail_count
            if fail_count == MAX_FAIL_COUNT:
                year_names[i]['index'] = None
                year_names[i]['citation'] = None
                try:
                    print "request fail:", fellow_name, tmp_url
                    print author_url
                    fail_fellow_names.append(fellow_name)
                except :
                    print "requests fail Exception"

            fail_count = 0

            if success_search :
                break

print len(fail_fellow_names)

f = file("name_index.json", "wb")
f.write(json.dumps(year_names))
f.close()

f = file("fail_name.json", "wb")
f.write(json.dumps(fail_fellow_names))
f.close()

#writer the result name-index to file
resfile = file('result.csv', 'wb')
writer = csv.writer(resfile)
writer.writerows(name_index_dict)
resfile.close()