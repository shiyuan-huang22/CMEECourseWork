#!/usr/bin/env python3

__appname__ = 'align_seqs.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

##Imports##
import csv ; import sys


"""Function to read sequences from a CSV file."""
def read_sequences():
    with open('../data/align_seqs.csv','r') as f:
        csvread = csv.reader(f)
        seqs = [ row[0] for row in csvread] 
        seq1 = seqs[0] ; seq2 = seqs[1]
        return seq1,seq2


"""Assign the longer sequence s1, and the shorter to s2
 l1 is length of the longest, l2 that of the shortest"""
def length_of_seq(seq1,seq2):
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1,s2,l1,l2

""" A function that computes a score by returning the number of matches starting
 from arbitrary startpoint (chosen by user)"""
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

""" now try to find the best match (highest score) for the two sequences"""
def best_match(s1,s2,l1,l2):
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)
    
    return my_best_align, my_best_score



"""Main entry of the program"""
def main(argv):
    seq1, seq2 = read_sequences()
    s1,s2,l1,l2 = length_of_seq(seq1,seq2)
    my_best_align,my_best_score = best_match(s1,s2,l1,l2)

    with open("../result/mybestalignment.txt", "w") as output:
         output.write('My best alignment is :'+ my_best_align+'\n' + 'My best score is :'+ str(my_best_score)+'\n')

    return 0
    

"""Make sure the main function is called from commond line"""
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)