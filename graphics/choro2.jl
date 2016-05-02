using ChoroplethMaps, DataFrames, Gadfly
set_default_plot_size(1500px, 750px)

df_theft = readtable("ca_theft.csv",header=true)
mf0 = mapify(df_theft, Provider.COUNTYSUMMARY(), key=:NAME, keepcols=[:STATEFP])
mf = mf0[mf0[:STATEFP] .== "06",:]

# Plotting the outline of some counties
layer1 = Gadfly.layer(mf, x=:CM_X, y=:CM_Y, group=:NAME, Theme(default_color=colorant"black"),
                      Geom.polygon(preserve_order=true, fill=false)) # preserve_order ensures the points are traced in order. 
Gadfly.plot(layer1, Coord.cartesian(fixed=true)) # Coord.cartesian: Prevents the map from being stretched out.

# Adding a second layer
center_x = -1.33e7
center_y = 4.5e6
sd = 2e5
n=100
layer2 = layer(x=randn(n)*sd+center_x, y=randn(n)*sd+center_y, color=randn(n), Geom.point, Theme(default_color=colorant"orange"))
layer2 = layer(x=randn(n)*sd+center_x, y=randn(n)*sd+center_y, color=randn(n), Geom.point, Theme(colorkey_swatch_shape=:square))
Gadfly.plot(layer1,layer2, Coord.cartesian(fixed=true))


