# -*- coding:gbk -*-
import os

result = []
ffo = open("w.txt")
fo = open("w-test.txt", "w")
result=list(set(ffo.readlines()))
result.sort()
fo.writelines(result)
fo.close()
ffo.close()
#os.remove("adblock+adguard.txt")
#os.rename("adblock+adguard-test.txt","adblock+adguard.txt")
