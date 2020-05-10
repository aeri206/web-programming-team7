import json, sys, os, requests, pprint
# module = os.path.dirname abspath 등 사용해서 # 종목번호 모듈화 파이썬 파일 임포트하기 위한 경로 추가
# sys.path.append()
sys.path.append("/Users/hyun/PycharmProjects/dart/companycode")
print(sys.path)

import new_company_code_200422 as company


json_url = "https://opendart.fss.or.kr/api/company.json"
args = "?crtfc_key="
private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
args2 = "&corp_code="
tmp = input("검색하고 싶은 기업 이름(DART상 정확한 이름)을 입력하시오 : ")
company_code = company.company[tmp]

final_url = json_url + args + private_key + args2 + company_code

print(final_url)

# TODO : 위까지는 모두 공통


response = requests.get(final_url)

pprint.pprint(response.text)
