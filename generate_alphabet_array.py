#! /usr/bin/python

import sys

if __name__ == "__main__":

    param = sys.argv
    count = int(param[1])-1
    num_alphabet = 26
    max_loop = 3
    max_count = 26**max_loop #26*26*26
    counter = 0

    print "max_count: %d" % max_count
    print "count: %d" % count+1
    if (count > max_count):
        print "ERROR: count is over max_count"
        sys.exit()

    # upper-case A-Z
    #for i in range(ord('A'), ord('A') + num_alphabet):
    #    print chr(i)

    # lower-case a-z
    #for i in range(ord('a'), ord('a') + num_alphabet):
    #    print chr(i)

    for i in range(ord('a'), ord('a') + num_alphabet):
        print chr(i)
        counter += 1
        if(counter > count):
            sys.exit()

    for i in range(ord('a'), ord('a') + num_alphabet):
        for j in range(ord('a'), ord('a') + num_alphabet):
            print chr(i)+chr(j)
            counter += 1
            if(counter > count):
                sys.exit()

    for i in range(ord('a'), ord('a') + num_alphabet):
        for j in range(ord('a'), ord('a') + num_alphabet):
            for k in range(ord('a'), ord('a') + num_alphabet):
                print chr(i)+chr(j)+chr(k)
                counter += 1
                if(counter > count):
                    sys.exit()
