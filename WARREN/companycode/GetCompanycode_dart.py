import requests, zipfile, pickle

# 공시정보 (공시검색/기업개황/공시서류원본파/고유번호) 중 고유번호를 가져오기 위한 코드
# API를 사용하여 받아오는 출력포멧과 인코딩은 ZIPFILE(BINARY), UTF-8임.


private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
url = "https://opendart.fss.or.kr/api/corpCode.xml"
args = "?crtfc_key="

final_url = url + args + private_key
print(final_url)


response = requests.get(final_url)

with open("new_company_code_200422.zip","wb") as f:
    f.write(response.content)

dart_zip = zipfile.ZipFile('/Users/hyun/PycharmProjects/dart/companycode/new_company_code_200422.zip','r') # 파일 위치 옮겨서 수정해야 함.
dart_zip.extractall('/Users/hyun/PycharmProjects/dart/companycode')
dart_zip.close()

print("END")


"""
with open("companycode.zip","wb") as f :
    pickle.dump(response.content,f)
"""
# pickle로 dump 하면 압축이 안풀린다. 왜지?