#!/usr/bin/env python
"""roll D&D dice"""

from sys import argv
from random import randrange
import re

if len(argv) < 2:
	raise ValueError("args are dice in D&D format like 2d6")

for roll in argv[1:]:
	matched = re.match(r'^(\d*)d(\d+)$', roll)
	if matched:
		print roll + ':'
		roll_sum = 0
		count = 0
		if len( matched.group(1) ):
			count = int( matched.group(1) )
		else:
			count = 1
		sides = int( matched.group(2) )
		for z in range(count):
			rolled = randrange(1, sides+1)
			print "\troll " + str(z) + ': ' + str(rolled)
			roll_sum += rolled

		possible = str( sides * count )
		print "\ttotal: " + str(roll_sum) + "/" + possible
	else:
		print roll + ' is not a dice in 3d8 format'
