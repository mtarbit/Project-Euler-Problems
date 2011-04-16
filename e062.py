#!/usr/bin/python

# $Id$

"""  """
__author__ = 'Matt Tarbit <matt.tarbit@isotoma.com>'
__docformat__ = 'restructuredtext en'
__version__ = '$Revision$'[11:-2]

def e62():
	cubes = {}
	
	n = 345
	while True:
		p = n ** 3
		k = ''.join(sorted(str(p)))
		n += 1

		if not cubes.get(k):
			cubes[k] = [p]
		else:
			cubes[k].append(p)
			
		if len(cubes[k]) >= 3:
			print k, cubes[k]
		if len(cubes[k]) == 5:
			return

if __name__ == "__main__":
	e62()

