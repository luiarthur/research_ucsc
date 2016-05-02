using Compose, Gadfly

p = compose(compose(context(), rectangle()), fill("tomato"))
p2 = compose(context(),
            (context(), circle(), fill("bisque")),
            (context(), rectangle(), fill("tomato")))

img = SVG("p2.svg", 8inch, 8inch)
draw(img,p2)

introspect(p2)

function sierpinski(n)
    if n == 0
        compose(context(), polygon([(1,1), (0,1), (1/2, 0)]))
    else
        t = sierpinski(n - 1)
        compose(context(),
                (context(1/4,   0, 1/2, 1/2), t),
                (context(  0, 1/2, 1/2, 1/2), t),
                (context(1/2, 1/2, 1/2, 1/2), t))
    end
end

img = SVG("sierpinski.svg", 4inch, 4(sqrt(3)/2)inch)
draw(img, compose(sierpinski(8), linewidth(0.1mm), fill(nothing), stroke("black")))


