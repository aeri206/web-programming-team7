from xml.etree import ElementTree as ET
import requests
import companycode.new_company_code_200422 as company
import companycode.new_company_code_backward as company_backward

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
args5 = "&fs_div="
# corp_code =
bsns_year = "2019" # 19년
report_code = "11011"
fs_div = "OFS"

# final_url = url + args1 + private_key + args2 + corp_code + args3 + bsns_year + args4 + report_code + args5 + fs_div

corp_code_list = list(company.company.values())

final_url_list = []
for corp_code in corp_code_list[:10]: # [:N]으로 조절하기.
    final_url = url + args1 + private_key + args2 + corp_code + args3 + bsns_year + args4 + report_code + args5 + fs_div
    final_url_list.append(final_url)
    for url in final_url_list:
        response = requests.get(url)
        file_name = company_backward.company[corp_code]
        f = open("%s.xml" % file_name, "w")
        f.write(response.text)
        f.close()
    tree = ET.parse("%s.xml" % file_name )
    root = tree.getroot()

    account_dic = {}
    major_account = ["유동자산","현금및현금성자산","기타유동자산","비유동자산","기타비유동자산","자산총계","유동부채","기타유동부채","비유동부채","기타비유동부채","부채총계","자본금","자본총계","수익(매출액)","영업이익(손실)",
                 "당기순이익(손실)","영업활동 현금흐름","투자활동 현금흐름","재무활동 현금흐름","배당금의 지급"]

    for i in root.iter("list") :
        if i[7].text in major_account:
            key = i[7].text
            value = i[10].text
            account_dic[key] = value
            account_dic[file_name] = corp_code

    with open("accounts.txt","a") as f:
        f.write("company = " + str(account_dic))
