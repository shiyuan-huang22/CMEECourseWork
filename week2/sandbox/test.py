from base64 import b16decode
from operator import ge


MyList = [3,2.44,'green',True]
MyList[0]
MyList[3]
MyList[2] = 'blue'
MyList
MyList.append('a new item') 
MyList
%who
type(MyList)
print(type(MyList))
MyList
del MyList[2]
MyList
FoodWeb=[('a','b'),('a','c'),('b','c'),('c','c')]
FoodWeb
FoodWeb[0]
FoodWeb[0][0] = "bbb"
FoodWeb[0] = ("bbb","ccc")
FoodWeb[0]

a = (1,2,[])
a
a[2].append(1000)
a
a[2].append(1000)
a
a[2].append((100,10))
a
a = (1,2,3)
b = a + (4,5,6)
b
c = b[1:]
c
b = b[1:]
b
a = ("1",2,True)
a

a = [5,6,7,7,7,8,9,9]
b = set(a)
b
c = set([3,4,5,6])
b & c
b | c

GenomeSize = {'Homo sapiens': 3200.0, 'Escherichia coli': 4.6, 'Arabidopsis thaliana': 157.0}
GenomeSize
GenomeSize['Arabidopsis thaliana']
GenomeSize['Saccharomyces cerevisiae'] = 12.1
GenomeSize
GenomeSize['Escherichia coli'] = 4.6 
GenomeSize
GenomeSize['Homo sapiens'] = 3201.1
GenomeSize

a = [1, 2, 3]
b = a
a.append(4)
print(a)
print(b)
a = [[1, 2], [3, 4]]
b = a[:]
print(a)
print(b)
a[0][1] = 22 
print(a)
print(b)
import copy

a = [[1, 2], [3, 4]]
b = copy.deepcopy(a)
a[0][1] = 22
print(a)
print(b)

s = " this is a string "
len(s) 
s.replace(" ","-") 
s.count("s")
t = s.split() 
t
t = s.split(" is ") 
t
t = s.strip() 
t
s.upper()
s.upper().strip() 
'WORD'.lower()












