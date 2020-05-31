from xml.etree import ElementTree as ET
# 받아와서 Zip File 압축 해제하여 얻은 CORPCODE.xml을 파싱하는 작업
# 결과물은 dic = { "삼성전자" : 034342, "현대자동차" : 234134 } 형태로 new_company_code_00000000.txt 으로 저

# TODO : XML 구조 파악

"""
<result>
    <list>
        <corp_code>00434003</corp_code>
        <corp_name>다코</corp_name>
        <stock_code> </stock_code>
        <modify_date>20170630</modify_date>
    </list>
    ....
</result>
"""

tree = ET.parse("CORPCODE.xml")
root = tree.getroot()  # xml 구조상에서 root인 <result> 아래의 모든 텍스트를 가져옴

# TODO : 딕셔너리를 만들어서 그냥 키 밸류로 바로 찾을 수 있게 파싱. 예컨데 code = { "삼성전자" : 034342, "현대자동차" : 234134 }

company_code = []

for list in root :
    key = list[1].text
    value = list[0].text
    company_code.append(key)
    company_code.append(value)

with open("new_company_code_200517.txt","w") as f:
    f.write(str(company_code))

with open("new_company_code_200517.py","w") as f:
    f.write("company = " + str(company_code))










# 하기 코드는 .text가 아닐 떄 가능한 .tostring 메소드
"""
company_code = {}
for list in root:
    tmpkey = ET.tostring(list[1], encoding="unicode")
    tmpvalue = ET.tostring(list[0], encoding="unicode")
    key = tmpkey.replace("<corp_name>","").replace("</corp_name>\n        ","")
    value = tmpvalue.replace("<corp_code>","").replace("</corp_code>\n        ","")
    company_code[key] = int(value)

with open("new_company_code_200421.txt","w") as f:
    f.write(str(company_code))
"""