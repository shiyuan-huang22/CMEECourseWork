#!/usr/bin/env python3

__appname__ = 'tuple.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""A script to print these on a separate line or output block by species"""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis
# Common name: Savannah sparrow
# Mass: 18.7
# ... etc.

# Hints: use the "print" command! You can use list comprehensions!

for n in birds:
    print("\nlatin name:", n[0],"\ncommon name:",n[1],"\nMass:",n[2],"\n")