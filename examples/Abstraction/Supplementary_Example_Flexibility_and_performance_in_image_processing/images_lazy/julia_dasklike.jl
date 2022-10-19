using TestImages, MappedArrays, ImageTransformations, StaticArrays, CoordinateTransformations, BenchmarkTools

lA = testimage("mri"; mmap=true) # `mmap=true` makes this lazy & scalable to huge datasets

# Perform a lazy square-root transform
sA = mappedarray(sqrt, lA)

# Perform a lazy resizing
tform = LinearMap(SDiagonal(1/1.5, 1/1.5, 1))
rA = WarpedView(sA, tform)  # works!

nothing
