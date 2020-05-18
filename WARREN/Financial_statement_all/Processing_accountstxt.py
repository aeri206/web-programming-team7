import re

f = open("accounts.txt","r")
contents = f.readlines()
f.close()

p = re.compile(r'.*유동자산.*')

with open("new_accounts.txt","w") as e:
    for i in contents:
        m = p.match(i)
        if m :
            e.write(m.group()+'\n')













"""
for i in contents:
    m = p.findall(i)
    print(m)
"""
"""
for i in contents:
    m = p.match(i)
    if m:
        print(m.group())
"""