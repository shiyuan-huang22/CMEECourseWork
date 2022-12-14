#!/usr/bin/env python3

__appname__ = 'LV2.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""


"""Example of numerical integration to solve the Lotka-Volterra model and plot
and it takes arguments for the four LV model parameters r, a, z, e from the command line"""


import sys
import matplotlib.pylab as p
import numpy as np
import scipy as sc
from scipy import integrate


def dCR_dt(pops, t = 0, r = 1.0, a = 0.1, z = 1.5, e = 0.75):

    """Returns the growth rate of consumer(e.g.,predator) and resource(e.g.,prey) population at given time"""

    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])


t = np.linspace(0, 15, 1000)
R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])
K = 40

def plot1(pops, t, r = 1.0, a = 0.1, z = 1.5, e = 0.75):

  """Plot population density ~ time"""

  f1 = p.figure()
  p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
  p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
  p.grid()
  p.legend(loc='best')
  p.xlabel('Time')
  p.ylabel('Population density')
  p.title('Consumer-Resource population dynamics')
  return f1
  

def plot2(pops, r = 1.0, a = 0.1, z = 1.5, e = 0.75):

  """Plot consumer density ~ resource density"""

  f2 = p.figure()
  p.plot(pops[:,0],pops[:,1], 'r-')
  p.grid()
  p.xlabel('Resource density')
  p.ylabel('Consumer density')
  p.title('Consumer-Resource population dynamics')
  return f2
 

def main(argv, r = 1.0, a = 0.1, z = 1.5, e = 0.75):

  """Main entry of this program"""

  pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
  p1 = plot1(pops,t,r,a,z,e)
  p2 = plot2(pops,r,a,z,e)
  p1.savefig('../results/LV2_model1.pdf')
  p2.savefig('../results/LV2_model2.pdf')
  return 0


if __name__ == "__main__":
  """Make sure the main function is called from command line"""

  if len(sys.argv) == 5:
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
    status = main(r, a, z, e)
    sys.exit(status)

  else:
    print("Using defalut set")
    status = main(sys.argv, r = 1.0, a = 0.1, z = 1.5, e = 0.75)
    sys.exit(status)