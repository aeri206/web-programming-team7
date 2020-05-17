from xml.etree import ElementTree as ET
import requests
import companycode.new_company_code_200517 as company

# xml or Json 형식으로 가져와서 파싱해서 딕셔너리 형태로 저장하기
# {'삼성전자' : 00126380, 2019 : "", "유동자산" : 2354235, "비유동자산" : 235235, "자산총계" : 23523525, .... }
# 여기에 추가로 P, EPS, PBR, 등 추가하고
# 비율 자체도 추가? 여튼 기본 자료까지만 만들어놓자
# N개 단위로 처리할 수 있게. 한번에 2000개 말고.

private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml"
args1 = "?crtfc_key="
args2 = "&corp_code="
args3 = "&bsns_year="
args4 = "&reprt_code="
args5 = "&fs_div="                          # 일단 개별로 긁어오자
corp_code = "00126380"
bsns_year = "2019"
report_code = "11011"
fs_div = "OFS"

final_url = url + args1 + private_key + args2 + corp_code + args3 + bsns_year + args4 + report_code + args5 + fs_div

response = requests.get(final_url)

f = open("%s.xml" % company.company[], "w")
f.write(response.text)
f.close()