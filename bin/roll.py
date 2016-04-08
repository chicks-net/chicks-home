#!/usr/bin/env python

from sys import argv
from random import randrange
import re

if len(argv) < 2:
	raise ValueError("args are dice in D&D format like 2d6")

args = argv[1:]

for roll in args:
	# TODO: handle missing count
	matched = re.match(r'^(\d+)d(\d+)$',roll)
	if matched:
		print roll + ':'
		count = int( matched.group(1) )
		sides = int( matched.group(2) )
		sum = 0
		for z in range(count):
			rolled = randrange(1,sides+1)
			print "\troll " + str(z) + ': ' + str(rolled)
			sum += rolled

		possible = str( sides * count )
		print "\ttotal: " + str(sum) + "/" + possible
	else:
		print roll + ' is not a dice in 3d8 format'
