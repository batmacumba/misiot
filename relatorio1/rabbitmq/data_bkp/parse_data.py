import os
import os.path
import sys

for dirpath, dirnames, filenames in os.walk("./resultados_spread/" + sys.argv[1]):
    for filename in [f for f in filenames]:
    	if sys.argv[2] in dirpath and sys.argv[3] in filename:
        	file = open(os.path.join(dirpath, filename), "r")
        	results = file.read().splitlines()
        	for line in results:
        		if sys.argv[4] in line:
        			desired_line = line.split()
        			for string in desired_line:
        				try:
        					print(float(string))
        				except:
        					pass
        			

        	file.close()