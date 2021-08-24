using TestImages, MappedArrays, ImageTransformations, StaticArrays, CoordinateTransformations, BenchmarkTools

lA = testimage("mri"; mmap=true)

# Perform a lazy square-root transform
sA = mappedarray(sqrt, lA)

# Perform a lazy resizing
tform = LinearMap(SDiagonal(1/1.5, 1/1.5, 1))
rA = WarpedView(sA, tform)

# While we could easily benchmark using `rA`, for comparability
# to Python we benchmark sA
print("time for a single element access: ")
@btime sA[100, 100, 5];
print("time for a single slice access: ")
@btime sA[:, :, 5];
nothing
