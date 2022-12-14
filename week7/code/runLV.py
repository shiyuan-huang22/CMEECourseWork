#!/usr/bin/env python3

__appname__ = 'runLV.py'
__author__ = 'Shiyuan Huang (sh422@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

"""Comparing the running speed between LV1.py and LV2.py"""

import cProfile as cp
import LV1
import LV2
import pstats

pf1 = cp.Profile()
pf1.enable()
LV1.main(0)
pf1.disable()
stats1 = pstats.Stats(pf1).sort_stats('tottime')
stats1.print_stats(10)


pf2 = cp.Profile()
pf2.enable()
LV2.main(1, 0.1, 1.5, 0.75)
pf2.disable()
stats2 = pstats.Stats(pf2).sort_stats('tottime')
stats2.print_stats(10)