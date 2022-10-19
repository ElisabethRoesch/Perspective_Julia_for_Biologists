#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 15 18:08:16 2021

@author: tim
"""
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 15 13:02:30 2021

@author: tim
"""
import dask.array as da
import dask_image as dimg
import dask_image.imread
import numpy as np
import timeit
from pathlib import Path

filename = Path("mri-stack-path.txt").read_text().strip()
lA = dimg.imread.imread(filename)
sA = np.sqrt(lA)

nrep = 10000
tscalar = timeit.timeit('sA[4, 99, 99]', number=nrep, globals={"sA": sA})/nrep
tslice = timeit.timeit('sA[4, :, :]', number=nrep, globals={"sA": sA})/nrep
tslicecopy = timeit.timeit('sA[4, :, :].copy()', number=nrep, globals={"sA": sA})/nrep
ns = [2,4,8,16,32,64,128]
tchunk = []
for n in ns:
    tchunk.append(timeit.timeit(f'sA[4, 0:{n-1}, 0:{n-1}]', number=nrep, globals={"sA": sA})/nrep)
tcopy = []
for n in ns:
    tcopy.append(timeit.timeit(f'sA[4, 0:{n-1}, 0:{n-1}].copy()', number=nrep, globals={"sA": sA})/nrep)


with open('timing_python.txt', 'w') as f:
    f.write('Python\n')
    f.write('Scalar: ' + str(tscalar))
    f.write('\nSlice: ' + str(tslice))
    f.write('\nSlice copy: ' + str(tslicecopy))
    f.write('\nn      tview     tcopy')
    f.write('\n---    -----     -----')
    for (n, t, tc) in zip(ns, tchunk, tcopy):
        f.write('\n%3d    %0.3g  %0.3g' % (n, t, tc))
    f.write('\n')
