#!/usr/bin/python
# -*- coding: ascii -*-
import os
import sys
import re

root = sys.argv[1]

# Regular expression for include files. The group in parentheses is for the
# actual file name.
pattern = r'#include\s*<([a-zA-Z0-9_/]*\.h)>'
fa = re.compile(pattern)

def count_headers():
    hist = {}

    for (path, subdirs, files) in os.walk(root):

        # Read in the first num_bytes of the file and look for matches against
        # the fa. num_bytes is a rough overestimate of the number of bytes
        # needed to get all of the #include lines in the file.
        for f in files:
            bytestr = open(os.path.join(path, f), 'rb', ).read()
            string = bytestr.decode("ascii", "ignore")

    	    # findall returns a list of strings that matched successfully
	    # against the fa.  The strings in the list are from group(1) of
	    # each match i.e. the header path such as linux/sched.h
            match_list = fa.findall(string)

            # scan the matches and put them in the hist
            for header in match_list:
                if header in hist:
                    hist[header] = hist[header] + 1
                else:
                    hist[header] = 1

    return hist

# write out include stats
def write_stats():
    pairs = []
    hist = count_headers()

    for header, freq in hist.items():
        pairs.append((freq, header))

    pairs.sort(reverse=True)

    for (freq, header) in pairs:
        print('  {0:s} ==> {1:d}'.format(header, freq))

write_stats()

if "__name__" == "__main__":
    import sys
