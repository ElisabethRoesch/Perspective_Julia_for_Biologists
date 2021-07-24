# Example based on: Gene Regulatory Network Inference from Single-Cell Data Using Multivariate Information Measures by Chan et al.
# Link to paper: https://doi.org/10.1016/j.cels.2017.08.014
# Link to package with more code examples: https://github.com/Tchanders/InformationMeasures.jl

using InformationMeasures

# Simple example
gene_1 = rand(700) # Gene 1 measured in 700 cells
gene_2 = rand(700) # Gene 2 measured in 700 cells
# Mutual information
mi_12 = get_mutual_information(gene_1, gene_2)

# Simulate single cell data set 1 (this is with 100 genes and 700 cells each)
n_genes_1 = 100
genes_1  = [rand(700) for i in 1:100]

# Simulate single cell data set 2 (this is with 1000 genes and 700 cells each)
n_genes_2 = 1000
genes_2  = [rand(700) for i in 1:1000]

mis_1 = Array{Float64}(undef, n_genes_1, n_genes_1)
@time for i in 1:n_genes_1
    for j in 1:n_genes_1
        mis_1[i,j] = get_mutual_information(genes_1[i], genes_1[j])
    end
end

mis_2 = Array{Float64}(undef, n_genes_2, n_genes_2)
@time for i in 1:n_genes_2
    for j in 1:n_genes_2
        mis_2[i,j] = get_mutual_information(genes_2[i], genes_2[j])
    end
end
