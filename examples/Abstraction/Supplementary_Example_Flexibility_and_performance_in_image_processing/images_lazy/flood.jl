using ImageSegmentation
using FileIO
using BenchmarkTools

workdir = joinpath(tempdir(), "images_demo")
filename = joinpath(workdir, "fz1037.tif")
img = load(filename)
idx = CartesianIndex(261,706,33)
seg = flood(img, idx; thresh=0.8)
println("npix: ", length(seg), ", fraction selected: ", sum(seg)/length(seg))
println("min time: ", @belapsed flood($img, $idx; thresh=0.8) seconds=1)
idx = CartesianIndex((idx[1]+1)÷2, (idx[2]+1)÷2, idx[3])   # the first `restrict` is only dims 1 & 2
for (i, thresh) in zip(1:4, (0.85,0.9,0.65,0.3))
    global idx, imgr, seg
    imgr = load(splitext(filename)[1] * "r$i.tif")
    seg = flood(imgr, idx; thresh)
    println("npix: ", length(seg), ", fraction selected: ", sum(seg)/length(seg))
    println("min time: ", @belapsed flood($imgr, $idx; thresh=$thresh) seconds=1)
    idx = CartesianIndex((idx[1]+1)÷2, (idx[2]+1)÷2, (idx[3]+1)÷2)  # remaining `restrict`s are along all dims
end
nothing
