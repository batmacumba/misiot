import os
import os.path
import sys
import statistics

results = []
for line in sys.stdin:
    results.append(float(line))

print("mean:  ", statistics.mean(results))
print("stdev: ", statistics.stdev(results))