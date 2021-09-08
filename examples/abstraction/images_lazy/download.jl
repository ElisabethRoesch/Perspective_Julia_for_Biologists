# Start Julia from this directory, with
#    JULIA_COPY_STACKS=1 julia --project
# This is required for BioformatsLoader (a wrapper around the Java-based Bio-formats package)

using Pkg
Pkg.instantiate()
Pkg.precompile()

using Downloads
using BioformatsLoader
using FileIO
using ImageBase
using TestImages
using ProgressMeter
BioformatsLoader.init()

workdir = joinpath(tempdir(), "images_demo")
if !isdir(workdir)
    mkpath(workdir)
end
# The (deliberately small) mri demo comes from Julia's TestImages repository.
# For Python's benefit, it's good to extract the "mri-stack.tif" path directly
# so we know they are working from the same data file.
testimages_filename = TestImages.image_path(TestImages.full_imagename("mri"))
open("mri-stack-path.txt", "w") do io
    println(io, testimages_filename)  # saves path in a text file in this directory
end

# Download and unpack the dataset for the image segmentation
segmentation_filename = joinpath(workdir, "segmentation.zip")
if !isfile(segmentation_filename)
    prog = Progress(1; desc="Downloading neuron tracing data set: ")
    function progupdate(total, now)
        prog.n = total
        update!(prog, now)
    end
    Downloads.download("https://data.uni-marburg.de/bitstream/handle/dataumr/63/2017-09-08_16%2733_1037.zip?sequence=13&isAllowed=y", segmentation_filename; progress=progupdate)
    run(`unzip -x $segmentation_filename -d $workdir`)
end
# Re-save as a tif file to circumvent the need for extra package installation
@info "Rewriting as an ordinary *.tif file at multiple resolutions"
img = bf_import(joinpath(workdir, "fz1037.lif"))[1]
pix = img["Pixels"]
@assert pix[:PhysicalSizeX] == pix[:PhysicalSizeY] && isapprox(pix[:PhysicalSizeZ], 2pix[:PhysicalSizeX], rtol=0.15)
img = colorview(Gray, normedview(dropdims(img; dims=(1, 5))))
save(joinpath(workdir, "fz1037.tif"), img)

# reduced-resolution variants
imgr = restrict(img, [1,2])   # now this has approximately isotropic resolution
save(joinpath(workdir, "fz1037r1.tif"), Gray{N0f8}.(clamp01nan.(imgr)))
imgr = restrict(imgr, [1,2,3])
save(joinpath(workdir, "fz1037r2.tif"), Gray{N0f8}.(clamp01nan.(imgr)))
imgr = restrict(imgr, [1,2,3])
save(joinpath(workdir, "fz1037r3.tif"), Gray{N0f8}.(clamp01nan.(imgr)))
imgr = restrict(imgr, [1,2,3])
save(joinpath(workdir, "fz1037r4.tif"), Gray{N0f8}.(clamp01nan.(imgr)))
