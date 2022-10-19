# Perspective: Julia for Biologists
*Authors: Elisabeth Roesch, Joe G. Greener, Adam L. MacLean, Huda Nassar, Christopher Rackauckas, Timothy E. Holy, Michael P.H. Stumpf.*


This is the online material accompanying [the paper "Julia for Biologists"](https://arxiv.org/abs/2109.09973) and [the JuliaCon presentation "Julia for Biologists"](https://www.youtube.com/watch?v=gRj7E5kYG1I). It's objective is to provide A. a diverse collection of Julia **code examples** and B. information on **related online material** in regards to Julia for biologists. 

The code [examples](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/tree/main/Examples) are chosen and organised in a way so that they highlight the three core language features of Julia: speed, abstraction and metaprogramming. We focus on capturing diversity in several regards:
- Examples are selected from multiple biological and methodological domains. 
- They are also designed to reflect different levels in regards to the computational focus of readers/listeners: high-level user cases (e.g. [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Metaprogramming/Dynamical-systems-modeling.ipynb)) and low-level user cases (e.g. [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/tree/main/Examples/Abstraction/images_lazy)).
- Additionally, they demonstrate different access points to Julia: Pluto notebooks (e.g. [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Speed/Example_Network_Inference_from_Single_Cell_Data), Jupyter notebooks (e.g. [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Metaprogramming/Dynamical-systems-modeling.ipynb)) and ``.jl`` files (e.g. [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/tree/main/Examples/Abstraction/images_lazy)).
____
### Example 1: Speed - Single cell data and network inference
____
[![name](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/figs/speed_network.png)](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Speed/Example_Network_Inference_from_Single_Cell_Data)

____

This example demonstrates the speed of Julia for vectorisable code and the code can be found [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Speed/Example_Network_Inference_from_Single_Cell_Data). If you haven't used Pluto notebooks before, see [here](https://github.com/fonsp/Pluto.jl) how to open them and explore!
* Domain: Single cell data
* Methodology: Network inference
* Feature: Speed for vectorisable code
* Packages: [InformationMeasures.jl](https://github.com/Tchanders/InformationMeasures.jl), [Graphs.jl](https://juliagraphs.org/Graphs.jl/dev/), [SimpleWeightedGraphs.jl](https://github.com/JuliaGraphs/SimpleWeightedGraphs.jl), [GraphPlot.jl](https://github.com/JuliaGraphs/GraphPlot.jl), [StatsPlots.jl](https://github.com/JuliaPlots/StatsPlots.jl)
* Access point: Pluto notebook
* Computational focus: high-level user case
____
### Example 2: Speed - Dynamical systems and Lotka-Volterra
____
[![name](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/figs/speed_lv.png)](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Speed/Supplementary_Example_Accelerating_Dynamical_Systems_Modeling_in_Systems_Biology_and_Pharmacology)
____
This example demonstrates the speed of Julia for non linear system code and can be found [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Speed/Supplementary_Example_Accelerating_Dynamical_Systems_Modeling_in_Systems_Biology_and_Pharmacology).
* Domain: Ecology
* Methodology: Dynamical systems
* Feature: Speed for non linear system code
* Packages: [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/)
* Access point: ``.jl`` file
* Computational focus: high-level user case
____
### Example 3: Abstraction - Structural bioinformatics
____
[![name](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/figs/abstraction_bioinfo.png)](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Abstraction/Example_Structural_bioinformatics_with_composable_packages)
____
This example demonstrates the composability of packages in Julia and the code can be found [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Abstraction/Example_Structural_bioinformatics_with_composable_packages).
* Domain: Structural bioinformatics
* Methodology: Alignments, protein structure
* Feature: Package composability
* Packages: [BioStructures.jl](https://github.com/BioJulia/BioStructures.jl), [BioSequences.jl](https://github.com/BioJulia/BioSequences.jl), [Bio3DViewer.jl](https://github.com/jgreener64/Bio3DView.jl), [MetaGraphs.jl](https://github.com/JuliaGraphs/MetaGraphs.jl), [Graphs.jl](https://juliagraphs.org/Graphs.jl/dev/)
* Access point: Jupyter notebook
* Computational focus: high-level user case
____
### Example 4: Abstraction - Image processing in Julia
____
[![name](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/figs/abstraction_im.png)](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/tree/main/Examples/Abstraction/images_lazy)
____
This example demonstrateds code reusability and the use of lazy operations in Julia and the code can be found [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Abstraction/Supplementary_Example_Flexibility_and_performance_in_image_processing).
* Domain: Cell biology and neuroscience
* Methodology: Image processing
* Feature: Code reusablility and lazy operations
* Packages: [JuliaImages suite](https://juliaimages.org/stable/)
* Access point: Jupyter notebook
* Computational focus: low-level user case
____
### Example 5: Metaprogramming - Biochemical reaction networks
____
[![name](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/figs/meta.png)](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Metaprogramming/Example_Biochemical_reaction_networks)
____
This example demonstrates metaprogramming with Julia and the code can be found [here](https://github.com/ElisabethRoesch/Perspective_Julia_for_Biologists/blob/main/Examples/Metaprogramming/Example_Biochemical_reaction_networks).
* Domain: Biochemistry
* Methodology: **Dynamical systems**
* Feature: Metaprogramming
* Packages: [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/), [Catalyst.jl](https://github.com/SciML/Catalyst.jl), [GpABC.jl](https://github.com/tanhevg/GpABC.jl), [Turing.jl](https://turing.ml/stable/) 
* Access point: Jupyter notebook
* Computational focus: high-level user case
____
____
#### General resources
  * Official website with tutorial videos and notebooks: https://julialang.org and https://julialang.org/learning/notebooks
  * Download and install Julia: https://julialang.org/downloads
  * Julia Academy, for free courses by core Julia developers: https://juliaacademy.com
  * The Julia Programming Language youtube channel: https://www.youtube.com/c/TheJuliaLanguage
  ____
#### Intermediate language features
  * "Developing Julia Packages" tutorial by Chris Rackauckas: https://www.youtube.com/watch?v=QVmU29rCjaA
  * "The Unreasonable Effectiveness of Multiple Dispatch" talk by Stefan Karpinski: https://www.youtube.com/watch?v=kc9HwsxE1OY
  * Introduction to metaprogramming workshop by David Sanders: https://www.youtube.com/watch?v=2QLhw6LVaq0
  ____
#### Switching to Julia
  * Using old R code in your new Julia project: https://juliainterop.github.io/RCall.jl/stable/gettingstarted/
  ____
#### Julia for biologists
  * BioJulia organisation website for bioinformatics packages and discussion: https://biojulia.net
  * Package searching on JuliaHub and Julia Observer: https://juliahub.com/ui/Packages and https://juliaobserver.com/categories/Biology
  * "Julia for Bioinformatics and Computational Biology" talk by Ben Ward, note this talk is from 2016 and some of the details are [out of date](https://biojulia.net/post/biojl): https://www.youtube.com/watch?v=0aa3g1NrLBM
  * "On the performance and design of BioSequences compared to the Seq language" blog post by Jakob Nybo Nissen and Ben J. Ward, which discusses some design tradeoffs and benchmarking in detail: https://biojulia.net/post/seq-lang
  ____
#### Community
  * Discourse, the main discussion forum for the Julia community: https://discourse.julialang.org
  * Slack, for quick and informal correspondence with a community of over 8,000 members: https://julialang.org/slack
  * Zulip, similar to Slack with unlimited message history: https://julialang.zulipchat.com
  * JuliaCon, the conference for all things Julia: https://juliacon.org
  * Current diversity and inclusion initiatives: https://julialang.org/diversity/current
____