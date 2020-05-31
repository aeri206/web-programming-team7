import requests
import companycode.new_company_code_200422 as company



code = "00894700"
a = list(company.company.values())
print(a.index(code))
print(len(a))

#b = list(company.company.keys())
#print(a.index("삼성전자"))

url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml?crtfc_key=fad3c5267be6330678a8bd1be6b49c7bf5cba2da&corp_code=%s&bsns_year=2018&reprt_code=11011&fs_div=OFS" % code
response = requests.get(url)
print(response.text)
print(response)

# 482까지도 없고
# 845까지도 없고 00452443
# 1622까지도 없고 00368472
# 2846까지도 없고 00343817
# 7292까지도 없고 00769820
# 14760 까지도 없고 00940115
# 21768 까지도 없고 00556387
# 30650 까지도 없고 00447362
# 33174 없고 01316537
# 43488 없고 01396621
# 57936 없고 01229037
# 70056 없고 00976271
# 70697 없고 00637983
# 71600 없고 01010509


# 근데 44930인 삼전은 있음. 이게 순서대로 있는게 아닌듯...