println("loading PlotlyJS")
using PlotlyJS, Rsvg

t1 = scatter(;x=[1, 2, 3, 4, 5], y=[1, 6, 3, 6, 1])
p1 = plot(t1)

PlotlyJS.savefig2(p1, "output_filename.pdf")
