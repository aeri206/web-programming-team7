from xml.etree import ElementTree as ET

tree = ET.parse("samsung.xml")
root = tree.getroot()

account_list = {}
major_account = ["유동자산","현금및현금성자산","기타유동자산","비유동자산","기타비유동자산","자산총계","유동부채","기타유동부채","비유동부채","기타비유동부채","부채총계","자본금","자본총계","수익(매출액)","영업이익(손실)",
                 "당기순이익(손실)","영업활동 현금흐름","투자활동 현금흐름","재무활동 현금흐름","배당금의 지급"]


for i in root.iter("list") :
    if i[7].text in major_account:
        print(i[7].text)
        key = i[7].text
        value = i[10].text
        account_list[key] = value
print(account_list)


