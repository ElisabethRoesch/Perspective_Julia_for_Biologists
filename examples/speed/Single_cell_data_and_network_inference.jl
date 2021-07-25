# Example based on: Gene Regulatory Network Inference from Single-Cell Data Using Multivariate Information Measures by Chan et al.
# Link to paper: https://doi.org/10.1016/j.cels.2017.08.014
# Link to package with more code examples: https://github.com/Tchanders/InformationMeasures.jl

using InformationMeasures

# Simple example
gene_1 = rand(700) # Gene 1 measured in 700 cells
gene_2 = rand(700) # Gene 2 measured in 700 cells

# Mutual information
mi_12 = get_mutual_information(gene_1, gene_2)

# Simulate single cell data set (this is with 100 genes and 100 cells each)
n_genes_1 = 100
genes_1  = [rand(n_genes_1) for i in 1:100]

# Mutual information for all genes in data set.
mis_1 = Array{Float64}(undef, n_genes_1, n_genes_1)
for i in 1:n_genes_1
    for j in 1:n_genes_1
        mis_1[i,j] = get_mutual_information(genes_1[i], genes_1[j])
    end
end
