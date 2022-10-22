#!/usr/bin/env python3


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

latin_names = {  n[0] for n in birds  } ; print("\n","latin_names:") ;print (latin_names)
common_names = { n[1] for n in birds  } ; print("\n","common_names:") ;print (common_names)
mean_body_masses = { n[2] for n in birds } ; print("\n","mean_body_masses:") ; print (mean_body_masses)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

latin_names_loop = []; common_names_loop = []; mean_body_masses_loop = []
for n in birds:
    latin_names_loop.append(n[0])
    common_names_loop.append(n[1])
    mean_body_masses_loop.append(n[2])

print("\n","latin_names:") ; print(latin_names_loop)
print("\n","common_names:") ;print(common_names_loop)
print("\n","mean_body_masses:") ;print(mean_body_masses_loop)


# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 