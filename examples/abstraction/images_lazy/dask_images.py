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
import skimage
from skimage.transform import rescale
import dask_image.imread
from dask import delayed
import numpy as np
import napari
import timeit

lA = dimg.imread.imread("/home/tim/.julia/artifacts/e752bdc739f34d02e79c7fa834bc2f2e0d71c7e0/mri-stack.tif")

# Perform a lazy square-root transform
sA = np.sqrt(lA)

# The following errors due to lack of float16 support in skimage
# rA = rescale(sA, 1.5)

# So, lazy-convert it to 'float32'
sA32 = sA.astype('float32')

# This works, but it's eager
rA = rescale(sA32, (1, 1.5, 1.5))

# Since rA is a numpy array, let's do the timing on the last dask array
nrep = 10000
print('time for a single element access: ', timeit.timeit('sA32[4, 99, 99]', number=nrep, globals={"sA32": sA32})/nrep)
print('time for a single slice access: ', timeit.timeit('sA32[4, :, :]', number=nrep, globals={"sA32": sA32})/nrep)
