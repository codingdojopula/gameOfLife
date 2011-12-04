# -*- coding: utf-8 -*-

import random as mod_random
import os as mod_os

try:
	DEFAULT_SIZE = int( raw_input( 'Size?' ) )
except:
	print 'Invalid values, using default...'
	DEFAULT_SIZE = 40

try:
	RANDOM_DENSITY = int( raw_input( 'Random density (1-100)?' ) )
except:
	print 'Invalid values, using default...'
	RANDOM_DENSITY = 30

def new_array():
	table = []

	for i in range( DEFAULT_SIZE ):
		row = []
		for j in range( DEFAULT_SIZE ):
			row.append( 0 )
		table.append( row )

	return table

def iteration( table ):
	""" Returns a new array based on "Game of life" """

	result_table = new_array()

	for i in range( DEFAULT_SIZE ):
		for j in range( DEFAULT_SIZE ):
			cell = table[ i ][ j ]

			live_neighbours_no = 0

			live_neighbours_no += table[ ( i + 1 ) % DEFAULT_SIZE ][ ( j - 1 ) % DEFAULT_SIZE ]
			live_neighbours_no += table[ ( i + 1 ) % DEFAULT_SIZE ][ j ]
			live_neighbours_no += table[ ( i + 1 ) % DEFAULT_SIZE ][ ( j + 1 ) % DEFAULT_SIZE ]
			live_neighbours_no += table[ i ][ ( j - 1 ) % DEFAULT_SIZE ]
			live_neighbours_no += table[ i ][ ( j + 1 ) % DEFAULT_SIZE ]
			live_neighbours_no += table[ ( i - 1 ) % DEFAULT_SIZE ][ ( j - 1 ) % DEFAULT_SIZE ]
			live_neighbours_no += table[ ( i - 1 ) % DEFAULT_SIZE ][ j ]
			live_neighbours_no += table[ ( i - 1 ) % DEFAULT_SIZE ][ ( j + 1 ) % DEFAULT_SIZE ]

			# 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population:
			if cell and live_neighbours_no < 2:
				result_table[ i ][ j ] = 0

			# 2. Any live cell with two or three live neighbours lives on to the next generation.
			elif cell and live_neighbours_no == 2 or live_neighbours_no == 3:
				result_table[ i ][ j ] = 1

			# 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
			elif cell and live_neighbours_no > 3:
				result_table[ i ][ j ] = 0

			# 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
			elif not cell and live_neighbours_no == 3:
				result_table[ i ][ j ] = 1

			else:
				result_table[ i ][ j ] = 0

	return result_table

def clear_screen():
	mod_os.system( 'clear' )

def print_table( table ):
	result = ''
	for i in range( DEFAULT_SIZE ):
		for j in range( DEFAULT_SIZE ):
			cell = table[ i ][ j ]
			if cell:
				result += '* '
			else:
				result += '  '
		result += '|\n'
	print result

table = new_array()

# Fill with random values:
for i in range( DEFAULT_SIZE ):
	for j in range( DEFAULT_SIZE ):
		table[ i ][ j ] = 1 if mod_random.randint( 0, 100 ) <= RANDOM_DENSITY else 0

for i in range( 1000000 ):
	clear_screen()

	print_table( table )

	table = iteration( table )

	raw_input( 'Next?' )
