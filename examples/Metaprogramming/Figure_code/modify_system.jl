using Catalyst, DifferentialEquations, Plots 

# Initial Catalyst model 
ErkModel = @reaction_network begin
    (k₁,k₋₁),  M + MKK   <--> M_MKK
    k₂,        M_MKK    --> Mp + MKK
    (k₃,k₋₃),  Mp + MKK  <--> Mp_MKK
    k₄,        Mp_MKK   --> Mpp + MKK 
    (h₁,h₋₁),  Mpp + MKP <--> Mpp_MKP
    h₂,        Mpp_MKP  --> Mp + MKP 
    (h₃,h₋₃),  Mp + MKP  <--> Mp_MKP
    h₄,        Mp_MKP   --> M + MKP
end k₁ k₂ k₃ k₄ h₁ h₂ h₃ h₄ k₋₁ k₋₃ h₋₁ h₋₃

# Default parameter values, simulation time and inital conditions for states
p = [:k₁ => 0.00166, :k₂ => 0.0001, :k₃ => 0.1,:k₄ => 0.00166, 
			:h₁ => 0.02, :h₂ => 0.001,  :h₃ => 0.02,  :h₄ => 0.02, 			
			:k₋₁ => 0.0001, :k₋₃ => 0.1,  :h₋₁ => 0.02, :h₋₃ => 0.02]
tspan = (0., 10.)
u0 = [:M => 201, :MKK => 100, :M_MKK => 10, :Mp_MKK => 20, :MKP => 2, 
		:Mpp => 23, :Mp => 10, :Mpp_MKP => 10, :Mp_MKP => 10]

# ODEProblem convertion 
ode_prob = ODEProblem(ErkModel, u0, tspan, p)

# Solve and visualise problem
sol  = solve(ode_prob)
p1 = plot(sol)

# Add reactions to Catalyst model 
@add_reactions ErkModel begin 
	m, M --> ∅
	o, Mp --> ∅
	n, Mpp -->  ∅ 
end n m o

# Set new parameter defaults
p = vcat(p, [:n => 0.001, :m => 0.001, :o => 0.001])

# ODEProblem convertion 
ode_prob2 = ODEProblem(ErkModel, u0, tspan, p)

# Solve and visualise problem
sol2 = solve(ode_prob2, kwargshandle=KeywordArgError)
p2 = plot(sol2)


# Visualise difference 
red_c = "#b85450"
green_c = "#81b267"
plot(p1, p2)
diffs = sol.-sol2
plot(sol[1,:])
plot!(sol2[1,:])
plot!(diffs[1,:])