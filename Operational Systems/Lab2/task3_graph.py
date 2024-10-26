#! /usr/bin/env python
import matplotlib.pyplot as plt
import numpy as np

with open("stat", "r") as file:
    stringNum = file.readline().strip().split(" ")

x = [i for i in range(0, 100)]

y = []

for num in stringNum:
    # Another fairness metrics
    # y.append(float(num))
    y.append(int(num))

median_value = np.median(y)


plt.xlabel("Seed value")
plt.ylabel("Difference between job completion time")

plt.axhline(median_value, color='red', linestyle='dashed', linewidth=1, label=f'Median: {median_value}')
plt.plot(x, y)

plt.savefig('task3.png', format='png')
