using ChoroplethMaps, DataFrames, Gadfly
set_default_plot_size(1500px, 750px)


df_theft = readtable("ca_theft.csv",header=true)
mf0 = mapify(df_theft, Provider.COUNTYSUMMARY(), key=:NAME, keepcols=[:STATEFP])
mf = mf0[mf0[:STATEFP] .== "06",:]

# Plotting the outline of some counties
layer1 = layer(mf, x=:CM_X, y=:CM_Y, group=:NAME, Theme(default_color=colorant"black"),
               Geom.polygon(preserve_order=true, fill=false)) # preserve_order ensures the points are traced in order. 

plot(layer1, Coord.cartesian(fixed=true)) # Coord.cartesian: Prevents the map from being stretched out.

# Adding a second layer
center_x = -1.33e7
center_y = 4.5e6
sd = 2e5
n=100
layer2 = layer(x=randn(n)*sd+center_x, y=randn(n)*sd+center_y, color=randn(n), Geom.point, Theme(default_color=colorant"orange"))
layer2 = layer(x=randn(n)*sd+center_x, y=randn(n)*sd+center_y, color=randn(n), Geom.rectbin)
plot(layer1,layer2, Coord.cartesian(fixed=true))


# Drawing a heatmap
using Colors
n = 50
x_seq = collect(linspace(-1.4e7,-1.25e7,n))
y_seq = collect(linspace(4e6,5e6,n))
x_grid = repeat(x_seq,inner=[n])
y_grid = repeat(y_seq,outer=[n])
z = sqrt(log(x_grid.^2) + log(y_grid.^2)) + randn(n*n)*2
z = x_grid + y_grid + rand(n*n)*1e6
layer3 = layer(x=x_grid, y=y_grid, color=z, Geom.rectbin) 
plot(layer3, Scale.ContinuousColorScale(p -> RGB(0,p,0)))

# Adding a heatmap
plot(layer1, layer3, 
     Coord.cartesian(fixed=true), Scale.ContinuousColorScale(p -> RGB(0,p,.5)))
plot(layer1, layer3, 
     Coord.cartesian(fixed=true), 
     Scale.ContinuousColorScale(Scale.lab_gradient(colorant"red",colorant"white",colorant"blue")))


df = DataFrame(NAME=["Alabama", "Arkansas", "Louisiana", "Mississippi", "Tennessee", "California"], 
               PCT=[26.6673430422, 15.6204437142, 32.4899197277, 37.5052896066, 17.0874767458, 20.0] )


p1 = plot(mapify(df, Provider.STATESUMMARY(), key=:NAME),
          x=:CM_X, y=:CM_Y, group=:NAME, color=:PCT,
          Geom.polygon(preserve_order=true, fill=true),
          Coord.cartesian(fixed=true))

