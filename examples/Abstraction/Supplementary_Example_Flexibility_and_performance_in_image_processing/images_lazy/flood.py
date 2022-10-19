import skimage.segmentation
import skimage.io
import os
import tempfile
import numpy as np
import napari
import timeit

workdir = os.path.join(tempfile.gettempdir(), "images_demo")
filename = os.path.join(workdir, "fz1037.tif")
img = skimage.io.imread(filename)
img2d = img[27,:,:]
# This is one of the few multidimensional algorithms in skimage
# In this case it works pretty well, with a few restrictions:
# - it's eager, which makes it hard to handle big data
# - it is written in Cython, so only certain eltypes are supported
idx = (32,260,705)
seg = skimage.segmentation.flood(img, idx, connectivity=1, tolerance=0.8*255)
setup = '''
import skimage.segmentation
'''
print("npix: ", seg.size, ", fraction selected: ", seg.sum()/seg.size)
t = timeit.timeit(setup=setup, stmt='skimage.segmentation.flood(img, idx, connectivity=1, tolerance=0.8*255)', globals={'img':img, 'idx':idx}, number=5)
print('min time: ', t)
idx = (idx[0], idx[1]//2, idx[2]//2)
for (i, thresh) in zip(range(1,5), (0.85,0.9,0.65,0.3)): #(0.8,0.85,0.65,0.3)):
    imgr = skimage.io.imread(os.path.splitext(filename)[0] + "r" + str(i) + ".tif")
    tol = np.floor(thresh*255)
    seg = skimage.segmentation.flood(imgr, idx, connectivity=1, tolerance=tol)
    print("npix: ", seg.size, ", fraction selected: ", seg.sum()/seg.size)
    t = timeit.timeit(setup=setup, stmt='skimage.segmentation.flood(imgr, idx, connectivity=1, tolerance=tol)', globals={'imgr':imgr, 'idx':idx, 'tol':tol}, number=5)
    print('min time: ', t)
    idx = (idx[0]//2, idx[1]//2, idx[2]//2)
# napari.view_image(seg)
