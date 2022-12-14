#!/usr/bin/env python3

__appname__ = 'dictionary.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""populate a dictionary called taxa_dic derived from
 taxa so that it maps order names to sets of taxa."""

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc

taxa_dic = {n[1]:set() for n in taxa}

for n in taxa:
        taxa_dic[n[1]].add(n[0])
        
print(taxa_dic)
