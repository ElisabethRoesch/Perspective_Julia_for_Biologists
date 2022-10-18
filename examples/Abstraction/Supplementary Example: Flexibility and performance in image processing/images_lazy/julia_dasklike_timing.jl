using TestImages, MappedArrays, ImageTransformations, StaticArrays, CoordinateTransformations, BenchmarkTools
using Printf
lA = testimage("mri"; mmap=true)
sA = mappedarray(sqrt, lA)

tscalar = @belapsed $sA[100, 100, 5]
tslice = @belapsed view($sA, :, :, 5)
tslicecopy = @belapsed $sA[:, :, 5]

ns = [2,4,8,16,32,64,128]
tchunk = Float64[]
tcopy = Float64[]
for n in ns
    push!(tchunk, @belapsed view($sA, 1:$n, 1:$n, 5) seconds=1)
    push!(tcopy, @belapsed $sA[1:$n, 1:$n, 5] seconds=1)
end

open("timing_julia.txt", "w") do f
    println(f, "Julia")
    println(f, "Scalar: ", tscalar)
    println(f, "Slice: ", tslice)
    println(f, "Slice copy: ", tslicecopy)
    println(f, "n      tview     tcopy")
    println(f, "---    -----     -----")
    for (n, t, tc) in zip(ns, tchunk, tcopy)
        @printf(f, "%3d    %0.3g  %0.3g\n", n, t, tc)
    end
end
