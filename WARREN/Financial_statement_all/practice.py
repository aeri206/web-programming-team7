import requests
import companycode.new_company_code_200422 as company

a = list(company.company.values())
print(a.index("00126380"))


#url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml?crtfc_key=fad3c5267be6330678a8bd1be6b49c7bf5cba2da&corp_code=00126380&bsns_year=2018&reprt_code=11011&fs_div=OFS"
#url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml?crtfc_key=fad3c5267be6330678a8bd1be6b49c7bf5cba2da&corp_code=00370787&bsns_year=2019&reprt_code=11011&fs_div=OFS"
#response = requests.get(url)
#print(response.text)
#print(response)
#url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&corp_code=00126380&bsns_year=2018&reprt_code=11011&fs_div=OFS"