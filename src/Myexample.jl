module Myexample

using FiniteDiff, ForwardDiff

# Define a simple function and compute its derivatives
f(x) = 2x^2 + x
g(x) = FiniteDiff.finite_difference_derivative(f, x)
h(x) = ForwardDiff.derivative(f, x)

export g,h

end
