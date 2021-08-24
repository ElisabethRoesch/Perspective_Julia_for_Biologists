using MappedArrays, CoordinateTransformations, Rotations
using ImageTransformations, ImageCore, ImageView, TestImages
using LinearAlgebra

# Load a 3d grayscale array
# This is a small demo and so we can use eager computation to prepare the input array.
# However, the lazy operations further below work even for huge datasets.
img = rawview(channelview(testimage("mri"))) .+ UInt16(100)

# define a function to subtract the bias and scale by gain
to_photons(x) = (x - 100)/1.8  # the numbers are specific to imaging conditions
#  a function to square-root transform the intensity,
# converting shot noise to Gaussian noise
to_gaussian(y) = sqrt(max(y, zero(y)))
# Create a "virtual" image in which these two operations are applied
# pixel-by-pixel
# ∘ means function composition
img_sigma = mappedarray(to_gaussian ∘ to_photons, img)
# Lazily create the rotated movie
# create the spatial rotation
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
