#!/bin/python
import os, sys, argparse
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.ticker import (MultipleLocator)
import seaborn as sns
sns.set()

def getParams():
	'''Parse parameters from the command line'''
	parser = argparse.ArgumentParser(description='Build insert-size histograms from ScriptManager bam-statistics pe-stats output.')

	parser.add_argument('-i','--input', metavar='input_fn', required=True, help='the "*InsertHistogram.out" file listing insert size counts')
	parser.add_argument('--scientific', action='store_true', help='label the y-axis with full numbers, not converted to scientific notation')
	parser.add_argument('--max-y', metavar='value', type=float, default=None, help='label the y-axis with full numbers, not converted to scientific notation')
	parser.add_argument('-o','--output', metavar='png_fn', required=True, help='the output figure image (use .svg or .png)')

	args = parser.parse_args()
	return(args)

'''
2023-03-23 18:16:24.561
InsertSize (bp) K562_CTCF_BX_hg19_rep1.bam
0       0.0
1       0.0
2       179.0
3       162.0
4       186.0
5       160.0
6       175.0
7       135.0
8       153.0
9       180.0
10      168.0
11      180.0
12      183.0
13      141.0
'''

# Main program which takes in input parameters
if __name__ == '__main__':
	'''Build insert-size histograms from ScriptManager bam-statistics pe-stats output.'''

	args = getParams()

	# Populate dataframe with tab file data
	filedata = pd.read_table(args.input, sep='\t', skiprows=[0,1], names=['InsertSize','ReadCount'])

	# Initialize plot
	fig, ax = plt.subplots()

	# Plot the filedata
	ax = sns.barplot(data=filedata, x='InsertSize', y='ReadCount', color='black', linewidth = 0)

	# Format axes and tickmarks
	ax.xaxis.grid(True)
	ax.xaxis.set_major_locator(MultipleLocator(50))
	ax.xaxis.set_major_formatter('{x:.0f}')
	ax.xaxis.set_minor_locator(MultipleLocator(10))
	ax.set_xlim(0, 500)

	# Title
	ax.set_title(os.path.basename(args.input))

	# Suppress Scientific notation
	if (args.scientific):
		ax.ticklabel_format(style='scientific', axis='y')
	else:
		ax.ticklabel_format(style='plain', axis='y')
	if (args.max_y != None):
		ax.set_ylim(0, args.max_y)

	# Fill line
	plt.fill_between(filedata.InsertSize.values, filedata.ReadCount.values, color='black')

	# Save figure as image
	sfig = ax.get_figure()
	sfig.savefig(args.output)
