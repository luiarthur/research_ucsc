#https://www.youtube.com/watch?v=JoRn4ryMclc
#julia -p 4

M = randn(2500,2500)
m = randn(200,200)

@everywhere function myinv(X)
  println(myid())
  inv(X) + 1
end

function remotecall_fetch_anon()
  println("Begin Testing Remote Call -> Fetch for built-in anonymous function")
  A =  remotecall(2, x -> sum(inv(x)), M)
  B =  remotecall(3, x -> sum(inv(x)), M)
  C =  remotecall(4, x -> sum(inv(x)), M)
  D =  remotecall(5, x -> sum(inv(x)), M)
  E =  remotecall(6, x -> sum(inv(x)), M)
  F =  remotecall(7, x -> sum(inv(x)), M)
  G =  remotecall(8, x -> sum(inv(x)), M)
  fetch(A)
  fetch(B)
  fetch(C)
  fetch(D)
  fetch(E)
  fetch(F)
  fetch(G)
  println("End of Testing Remote Call -> Fetch for built-in anonymous function")
end

function remotecall_then_fetch_custom_function()
  println("Begin Remote Call -> Fetch for custom function")
  A =  remotecall(2, myinv, M);
  B =  remotecall(3, myinv, M);
  C =  remotecall(4, myinv, M);
  D =  remotecall(5, myinv, M);
  E =  remotecall(6, myinv, M);
  F =  remotecall(7, myinv, M);
  G =  remotecall(8, myinv, M);
  fetch(A)
  fetch(B)
  fetch(C)
  fetch(D)
  fetch(E)
  fetch(F)
  fetch(G)
  println("End of Testing Remote Call -> Fetch for custom function")
end

function sequential_test()
  println("Begin Testing sequential implementation")
  myinv(M);
  myinv(M);
  myinv(M);
  myinv(M);
  myinv(M);
  myinv(M);
  myinv(M);
  println("End of Testing sequential implementation")
end

function spawn_fetch()
  println("Begin Testing Spawn -> Fetch")
  A=@spawn myinv(M)
  B=@spawn myinv(M)
  C=@spawn myinv(M)
  D=@spawn myinv(M)
  E=@spawn myinv(M)
  F=@spawn myinv(M)
  G=@spawn myinv(M)
  fetch(A)
  fetch(B)
  fetch(C)
  fetch(D)
  fetch(E)
  fetch(F)
  fetch(G)
  println("End of Testing Spawn -> Fetch")
end

function spawn_fetch_mix()
  println("Begin Testing Spawn -> Fetch")
  A=@spawn myinv(M)
  B=@spawn myinv(m)
  C=@spawn myinv(M)
  D=@spawn myinv(m)
  E=@spawn myinv(M)
  F=@spawn myinv(m)
  G=@spawn myinv(M)
  fetch(A)
  fetch(B)
  fetch(C)
  fetch(D)
  fetch(E)
  fetch(F)
  fetch(G)
  println("End of Testing Spawn -> Fetch")
end

#=
include("parallelJulia.jl")
@time remotecall_fetch_anon()
@time remotecall_then_fetch_custom_function()
@time sequential_test()
@time spawn_fetch();
@time spawn_fetch_mix();
@time a = pmap(myinv,[M for i in 1:7]);

@time pdf(Normal(0,1),randn(100))
N = Normal(0,1)
@time a =[ @spawn pdf(N,randn(100,100)) for i in 1:10000];
@time b =[ pdf(N,randn(100,100)) for i in 1:10000];
fetch(a[1])
b[1]
=#
