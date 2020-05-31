from xml.etree import ElementTree as ET

tree = ET.parse("samsung.xml")
root = tree.getroot()

account_list = []



f = open("account_list.txt","w")

for account in root:
    f.write(str(account[7].text + "\n"))

f.close()