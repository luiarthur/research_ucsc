println("loading PlotlyJS")
using PlotlyJS, Rsvg

t1 = scatter(;x=[1, 2, 3, 4, 5], y=[1, 6, 3, 6, 1])
p = plot(t1)

#=
  include("testplotlyjs.jl")
  PlotlyJS.savefig3(p, "p.pdf")
=#

#x = randn(100)
#y = randn(100)
#z = randn(100)
#
#t2 = plot(scatter(;x=x, y=y,mode="lines+markers",marker_size=3))
#plot(scatter(;x=x, y=y,mode="markers",marker=attr(size=10,symbol=:square,color=:red)))
#
#plot([Plot(t1) Plot(t1)])


