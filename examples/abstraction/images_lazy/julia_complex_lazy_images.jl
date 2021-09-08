using MappedArrays, CoordinateTransformations, Rotations
using ImageTransformations, ImageCore, ImageView, TestImages
using LinearAlgebra

# Load a 3d grayscale array
## The source array mimics a camera with a bias of 100.
## We prepare it "eagerly" (it's actually a small file) to mimic the types
## you might be presented when loading the data directly.
## However, these steps can easily be replaced with lazy counterparts
## (`channelview` and `rawview` are already lazy, so one just needs to
## replace the `.+` with `mappedarray(x -> x + UInt16(100), img)`.)
img = rawview(channelview(testimage("mri"))) .+ UInt16(100)

# define a function to subtract the bias and scale by gain
#   100 = bias, 1.8 = digital #s/photon (a measure of gain)
#   These would depend on your camera
to_photons(x::T) where T = (max(x, T(100)) - T(100))/1.8  # avoid unsigned wraparound
# Create a "virtual" image in which these two operations are applied
# pixel-by-pixel
# ∘ means function composition
# we use `sqrt` to convert shot-noise into Gaussian-noise, so the
# output intensities are in units of √γ
# (it also stretches the contrast)
img_sigma = mappedarray(sqrt ∘ to_photons, img)
# Create the lazily-rotated movie
# create the spatial rotation as a rotation around the `z` axis
# (the third array axis)
θ = π/8
tfm = AffineMap(RotZ(θ), (I - RotZ(θ))*center(img))
# a rotated view occupying the same ROI
imgr = warpedview(img_sigma, tfm, axes(img))
# Pick a reference image
imgref = imgr[:, :, end ÷ 2]   # midpoint
# Lazily replicate the reference image across time
movieref = view(imgref, :, :, ones(Int, size(img, 3)))
# Lazily overlay in separate color channels
overlay = colorview(RGB, imgr, movieref, zeroarray)
# Inspect the result
imshow(overlay)
