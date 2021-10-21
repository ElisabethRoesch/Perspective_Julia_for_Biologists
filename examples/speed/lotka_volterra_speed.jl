using BenchmarkTools
function lotka_volterra!(du, u, p, t)
  x, y = u
  α, β, δ, γ = p
  du[1] = dx = α*x - β*x*y
  du[2] = dy = -δ*y + γ*x*y
  nothing
end

du = zeros(2)
u = ones(2)
p = [1.5,1.0,3.0,1.0]
@btime lotka_volterra!(du,u,p,0.0) # 19.559 ns (0 allocations: 0 bytes)
