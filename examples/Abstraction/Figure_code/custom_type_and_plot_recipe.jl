using RecipesBase, Statistics

mutable struct MyBioStruc
    predicted_AA::Vector{Char}      # Predicted AA
    certainty_AA::Vector{Float64}   # Certainty of prediction
    study::String                   # Study name of raw data
    alg::String                     # Prediction alogrithm
end

res_1 = MyBioStruc(
    ['A', 'A', 'L', 'A'], 
    [0.5, 0.3, 0.3, 0.4], 
    "StudyA", 
    "Alg1")

@recipe function f(myBioStruc::MyBioStruc) 
    alpha --> mean(myBioStruc.certainty_AA)     # Set mean as opacity
    return myBioStruc.predicted_AA              # Visualizing predicted AA
end 

using Plots
# Visualise test structure
plot(res_1)
# Visualise default setting for comparison
plot(['A', 'A', 'L', 'A'])