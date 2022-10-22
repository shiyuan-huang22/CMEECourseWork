#!/usr/bin/env python3

########################

"""Print 'hello' to console as it find 
a number which is times of 3"""
def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)


"""Print 'hello' to console as it find a number 
x mod 4(or 5) =3"""
########################
def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)


"""Print 'hello' to the console for every iteration 
between (x,y)."""
########################
def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)


"""Print 'hello' to the console x+3 times
 when x is not 15"""
########################
def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)


"""Print 'hello' to the console when x>18
and 7 more 'hello' when x>31"""
########################
def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)


"""Print 'hello' to the console"""
# WHILE loop with BREAK
def hello_6(x, y):
    while x: # while x is True
        print("hello! " + str(y))
        y += 1 # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6 (True, 0)