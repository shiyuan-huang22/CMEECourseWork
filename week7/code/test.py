"""Example of numerical computing in Python."""

__appname__ = 'test.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

import numpy as np
a = np.array(range(5)) # a one-dimensional array
a
mat = np.array([[0, 1], [2, 3]])
mat[:,0]
mat[-1,0]
mat[0,-2]
np.append(mat ,[[12,12]], axis = 0)
newRow = [[12,12]]
mat = np.append(mat, newRow, axis = 0)
np.delete(mat, 2 ,0)    
mat.ravel()
mat.reshape((6,1))
mat.shape
mm = np.arange(16)
mm = mm.reshape(4,4)
mm
mm.transpose()
mm + mm.transpose()
mm // (mm + 1).transpose()
mm.dot(mm)
print(type(mm))
mm = np.matrix(mm)
mm * mm

import scipy as sc
from scipy import stats
sc.stats.norm.rvs(size = 10)
np.random.seed(1234)
sc.stats.norm.rvs(size = 10)
sc.stats.norm.rvs(size = 5, random_state = 1234)
sc.stats.randint.rvs(0, 10, size = 7)

import scipy.integrate as integrate
y = np.array([5, 20, 18, 19, 18, 7, 4])
import matplotlib.pylab as p
p.plot(y)
area = integrate.trapz(y, dx = 2)
print("area =", area)
area = integrate.simps(y, dx = 2)
print("area =", area)

