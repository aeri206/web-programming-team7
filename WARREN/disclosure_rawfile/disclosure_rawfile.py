import json, sys, os, requests, pprint, zipfile

json_url = "https://opendart.fss.or.kr/api/document.xml"
args = "?crtfc_key="
private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
args2 = "&rcept_no="
args2_key = "20190401004781"

final_url = json_url + args + private_key + args2 + args2_key

print(final_url)

# TODO : 위까지는 모두 공통(url 부분 빼고)

response = requests.get(final_url)

file_name = "company_disclosure_raw.zip"

with open(file_name,"wb") as f:
    f.write(response.content)

dart_zip = zipfile.ZipFile('/Users/hyun/PycharmProjects/dart/disclosure_rawfile/%s' % file_name,'r')
dart_zip.extractall('/Users/hyun/PycharmProjects/dart/disclosure_rawfile')
dart_zip.close()

print("END")