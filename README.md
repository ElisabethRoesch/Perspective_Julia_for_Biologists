# Perspective: Julia for Biologists
This is the online material connected to 
- the paper preprint: https://arxiv.org/abs/2109.09973
- the presentation: https://www.youtube.com/watch?v=gRj7E5kYG1I
## 1. Examples
### Speed: Example 1 - Single cell data and network inference
* Domain: Single cell data
* Methodology: Network inference
* Feature: Speed for vectorisable code
* Packages: [InformationMeasures.jl](https://github.com/Tchanders/InformationMeasures.jl)
### Speed: Example 2 - Dynamical systems and Lotka-Volterra
* Domain: Ecology
* Methodology: Dynamical systems
* Feature: Speed for non linear system code
* Packages: [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/)
### Abstraction: Example 1 - Structural bioinformatics
* Domain: Structural bioinformatics
* Methodology: Alignments, protein structure
* Feature: Package composability
* Packages: BioStructures.jl, BioSequences.jl, Bio3DViewer.jl, MetaGraphs.jl, LightGraphs.jl
### Abstraction: Example 2 - Image processing in Julia
* Domain: Cell biology and neuroscience
* Methodology: Image processing
* Feature: [Code reusablility and lazy operations](examples/abstraction/images_lazy/README.md)
* Packages: [JuliaImages suite](https://juliaimages.org/stable/)
### Metaprogramming: Example - Biochemical reaction networks
* Domain: Biochemistry
* Methodology: Dynamical systems
* Feature: Metaprogramming
* Packages: [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/), [Catalyst.jl](https://github.com/SciML/Catalyst.jl), [GpABC.jl](https://github.com/tanhevg/GpABC.jl), [Turing.jl](https://turing.ml/stable/) 
## 2. Links for learning more about Julia
#### General resources
  * Official website with tutorial videos and notebooks: https://julialang.org and https://julialang.org/learning/notebooks
  * Download and install Julia: https://julialang.org/downloads
  * Julia Academy, for free courses by core Julia developers: https://juliaacademy.com
  * The Julia Programming Language youtube channel: https://www.youtube.com/c/TheJuliaLanguage
#### Intermediate language features
  * "Developing Julia Packages" tutorial by Chris Rackauckas: https://www.youtube.com/watch?v=QVmU29rCjaA
  * "The Unreasonable Effectiveness of Multiple Dispatch" talk by Stefan Karpinski: https://www.youtube.com/watch?v=kc9HwsxE1OY
  * Introduction to metaprogramming workshop by David Sanders: https://www.youtube.com/watch?v=2QLhw6LVaq0
#### Switching to Julia
  * Using old R code in your new Julia project:https://juliainterop.github.io/RCall.jl/stable/gettingstarted/
#### Julia for biologists
  * BioJulia organisation website for bioinformatics packages and discussion: https://biojulia.net
  * Package searching on JuliaHub and Julia Observer: https://juliahub.com/ui/Packages and https://juliaobserver.com/categories/Biology
  * "Julia for Bioinformatics and Computational Biology" talk by Ben Ward, note this talk is from 2016 and some of the details are [out of date](https://biojulia.net/post/biojl): https://www.youtube.com/watch?v=0aa3g1NrLBM
  * "On the performance and design of BioSequences compared to the Seq language" blog post by Jakob Nybo Nissen and Ben J. Ward, which discusses some design tradeoffs and benchmarking in detail: https://biojulia.net/post/seq-lang
#### Community
  * Discourse, the main discussion forum for the Julia community: https://discourse.julialang.org
  * Slack, for quick and informal correspondence with a community of over 8,000 members: https://julialang.org/slack
  * Zulip, similar to Slack with unlimited message history: https://julialang.zulipchat.com
  * JuliaCon, the conference for all things Julia: https://juliacon.org
  * Current diversity and inclusion initiatives: https://julialang.org/diversity/current
