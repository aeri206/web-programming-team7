from xml.etree import ElementTree as ET
import requests
import companycode.new_company_code_200422 as company
import companycode.new_company_code_backward as company_backward

private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
url = "https://opendart.fss.or.kr/api/fnlttSinglAcntAll.xml"
args1 = "?crtfc_key="
args2 = "&corp_code="
args3 = "&bsns_year="
args4 = "&reprt_code="
args5 = "&fs_div="
corp_code_test ="00126380"
bsns_year = "2019" # 19년
report_code = "11011"
fs_div = "OFS" # or CFS

"""
test_url = url + args1 + private_key + args2 + corp_code_test + args3 + bsns_year + args4 + report_code + args5 + fs_div
response = requests.get(test_url)
print(response.text)
"""

corp_code_list = list(company.company.values()) # ["234235","2342352",....,"234234"]

for corp_code in corp_code_list[44930:44931]: # [:N]으로 조절하기.
    final_url = url + args1 + private_key + args2 + corp_code + args3 + bsns_year + args4 + report_code + args5 + fs_div
    print(final_url)
    response = requests.get(final_url)
    print(response)
    print(response.text)
    file_name = company_backward.company[corp_code]

    tree = ET.fromstring(response.text)
    root = tree.text
    print(root)

    for i in root.iterfind("list"):
        print(i.text)

