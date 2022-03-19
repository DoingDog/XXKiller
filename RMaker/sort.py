# -*- coding:utf-8 -*-
import os

result = []
ffo = open("nord.txt", encoding="utf8")
fo = open("nordv.txt", "w", encoding="utf8")
result=list(set(ffo.readlines()))
result.sort()
fo.writelines(result)
fo.close()
ffo.close()
#os.remove("adblock+adguard.txt")
#os.rename("adblock+adguard-test.txt","adblock+adguard.txt")
