# Abstraction in image processing

This document and accompanying code examples provide evidence and additional discussion about Julia's advantages for array and image processing.

## A case study: `flood`

Fig. 5a shows timing data on an example of a non-vectorizable algorithm, a [flood fill](https://en.wikipedia.org/wiki/Flood_fill) algorithm familiar to many users of drawing programs' bucket-fill feature.  This algorithm was chosen as a case study because it is one of Scikit-image's minority of morphological/segmentation algorithms that is applicable to both two- and three-dimensional images and whose performance is good enough to be practical on intermediate-sized images.

This algorithm is implemented in Python's Scikit-image with a [Python wrapper](https://github.com/scikit-image/scikit-image/blob/6ba337500114102b88817afc409203241e21b337/skimage/morphology/_flood_fill.py) and [Cython core](https://github.com/scikit-image/scikit-image/blob/178e05f17855859d6661ebb6e04d8ddcb50c1cc5/skimage/morphology/_flood_fill_cy.pyx); Cython is one of the two most common "accelerators" for Python, allowing C-compilation of Python-esque code.  For comparison purposes, the Julia implementation [`ImageSegmentation.flood`](https://github.com/JuliaImages/ImageSegmentation.jl/blob/22a75f77214aad249ddf3808aa9b0937a5423641/src/flood_fill.jl) is deliberately designed to use the same (elementary) core algorithm, which examines each point's neighbors and pushes matching neighbors on a queue.

As shown in Fig. 5a, despite being written in Cython, the Python implementation lags Julia's by several orders of magnitude.  This is despite the Julia implementation being considerably shorter (11 lines in Julia's core `_flood_fill!` vs 34 lines for the Cython cores, not including comments or blank lines).  The code used to generate these performance measurements is described further [below](#demos).

However, Julia's advantages go well beyond performance, and here we explore these advantages.

### Advantage #1: scaling to big data

The Scikit-image implementation begins with `image = np.asarray(image)`, which immediately forces conversion to an in-memory NumPy array.  This excludes data sets larger than system memory from the very first line of code.  Moreover, the output array `flags` is also allocated in-memory as a NumPy array.  These rigid types are required because the Cython code is compiled and shipped for [10 specific array/element combinations](https://github.com/scikit-image/scikit-image/blob/178e05f17855859d6661ebb6e04d8ddcb50c1cc5/skimage/morphology/_flood_fill_cy.pyx#L17-L27).

In contrast, the Julia code allows any `AbstractArray` input, and this can include an array that has been [memory-mapped](https://en.wikipedia.org/wiki/Virtual_memory) (as loaded by the [TiffImages.jl](https://github.com/tlnagy/TiffImages.jl), [NRRD.jl](https://github.com/JuliaIO/NRRD.jl), or other packages that support loading memory-mapped images), thus supporting data sets much larger than system memory that nevertheless behave (except for occasional delays for disk input/output) as if they are a single large array.  Optionally, such arrays can also be lazily-transformed by other preprocessing steps.  The core of the Julia algorithm is [`flood_fill!`](https://github.com/JuliaImages/ImageSegmentation.jl/blob/22a75f77214aad249ddf3808aa9b0937a5423641/src/flood_fill.jl#L96-L111) and the non-exported (internal) function [`_flood_fill!`](https://github.com/JuliaImages/ImageSegmentation.jl/blob/22a75f77214aad249ddf3808aa9b0937a5423641/src/flood_fill.jl#L118-L130), both of which allow the user to supply the output `dest` array as an argument.  As a consequence, the user can choose the output type for `dest` as a [`Mmap.mmap`ped](https://docs.julialang.org/en/v1/stdlib/Mmap/#Mmap.mmap) array (allowing outputs much larger than system memory), or for sparse floods as a [sparse array](https://github.com/Jutho/SparseArrayKit.jl) implemented an `AbstractArray` type that uses a dictionary for storage of individual nonzero entries and thus can efficiently implement all the operations need for the `flood` algorithm at a fraction of the memory cost.

Julia's flexibility in input and output array types does not come with any unnecessary overhead, because the code gets JIT-compiled for each combination of `src` and `dest` arrays.  Typically, their specific indexing operations get inlined and streamlined into the compiled code, and thus performs as if the developer had written a bespoke implementation for that specific combination of inputs.

### Advantage #2: greater flexibility for voxel matches

The Scikit-image implementation supports two kinds of voxel-matching: exact and approximate.  Both require that the voxels be represented by a single real number encoded as one of 10 builtin numeric types (the standard hardware-backed signed and unsigned integers as well as single- and double-precision floating-point).  For approximate matching, an optional tolerance input gets translated into lower- and upper-bound, and any number between them is considered matching.

In contrast, the Julia implementation allows the user to supply an arbitrary matching function `f`.  This allows supporting the same options as in Python, for example:

- `f = isequal(0.8)` creates a function that matches elements exactly equal to 0.8;
- `f = x -> 0.7 < x < 0.9` matches all values between 0.7 and 0.9.

However, any other matching function can be constructed.  As a practical example, consider a case of a two-channel fluorescence microscopy image, where a structure-of-interest is identified by its bright red fluorescence.  We could define our matching function as

```julia
mostly_red(c::AbstractRGB) = red(c) > 2*green(c) && red(c) > 0.4
```

to impose a requirement that the red channel be more than twice as intense as the green channel and also above a certain minimum threshold intensity.

Again, Julia will JIT-compile (and inline) this specific matching function into the running code, ensuring that this flexibility comes with no cost to performance.

### Advantage #3: a single implementation for `flood` and `flood_fill!`

Scikit-image also provides `flood_fill` to fill an image with a chosen colors. This is [implemented](https://github.com/scikit-image/scikit-image/blob/6ba337500114102b88817afc409203241e21b337/skimage/morphology/_flood_fill.py#L105-L111) by first computing an output Boolean-valued `mask` and then setting the `True` voxels to have the new fill value.  While Julia also (trivially) supports this mode of operation with `img[flood(args...)] .= fillvalue`, it also allows unified support for a "fill-as-you-go" implementation by supporting a `fillvalue` and optional accompanying `isfilled` function, allowing the caller to define how to test whether a particular array location has been visited.  In cases where the fill value is disjoint from any of the values in the input, this allows the entire problem to be solved with a single graph-traversal of the source array.

## Demonstrations and source files for the figures {#demos}

In Fig. 5 we present comparisons between Python and Julia in the domain of image processing; this section documents the way this comparison was performed.  These demonstrations were created on Ubuntu 20.04 using Julia 1.6.2 and Python 3.8.11.

The accompanying source files are:

- [download.jl](download.jl) to download the data used in the two examples (one deliberately small, stored in the [TestImages.jl](https://github.com/JuliaImages/TestImages.jl) repository, and the other a moderate-sized public data set). To run this script:

  + navigate to this directory in your terminal
  + launch Julia with `JULIA_COPY_STACKS=1 julia --project`. The special invocation is needed because the file is stored in a vendor-specific format that requires the [BioformatsLoader](https://github.com/ahnlabb/BioformatsLoader.jl) package, which wraps a [Java library](https://www.openmicroscopy.org/bio-formats/).
  + After the script finishes, quit your Julia session (`exit()` or hit Ctrl-D)

  This script should be executed once before any of the next steps.  It will download the larger image to your temporary directory.  It will also install all necessary Julia packages.  In future steps, launch Julia with `julia --project` from this directory, or select this environment with `Pkg.activate`.  (Henceforth, you do not need `JULIA_COPY_STACKS=1`.)
- For executing the Python code, users will need to manually install the required packages. `napari` is only needed for visualization and may be skipped.
- [dask_images.py](dask_images.py) contains the Python implementation and some of the composability problems that arise as illustrated in Fig. 5c.  This is mostly documented in the code (running it does not generate obvious errors, as they are commented out). The Julia analog is [julia_dasklike.jl](julia_dasklike.jl).
- execute [dask_arrays_timing.py](dask_arrays_timing.py) for measuring the timing of a very simple operation, 2d region-of-interest (ROI) extraction, as a function of the ROI size along each axis.  The julia equivalent is [julia_dasklike_timing.jl](julia_dasklike_timing.jl).  The output of both are text files, `timing_python.txt` and `timing_julia.txt`.
- The `flood` examples can be run with `python3 flood.py` and `julia --project flood.jl`. Their output is displayed in the console.

A much more sophisticated example demonstrating more of the kinds of lazy transformations possible with Julia can be found in [`julia_complex_lazy_images.jl`](julia_complex_lazy_images.jl).
The ImageView package can be installed with `Pkg.add("ImageView")`.
