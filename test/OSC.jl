A = rand(100, 100)
B = rand(100, 100)
C = rand(100, 100)
using BenchmarkTools
# function inner_rows!(C,A,B)
#   for i in 1:100, j in 1:100
#     C[i,j] = A[i,j] + B[i,j]
#   end
# end
# @btime inner_rows!(C,A,B)

# function inner_cols!(C,A,B) # faster as julia is column major
#     for j in 1:100, i in 1:100
#       C[i,j] = A[i,j] + B[i,j]
#     end
#   end
#   @btime inner_cols!(C,A,B)

#   function inner_alloc!(C,A,B)
#     for j in 1:100, i in 1:100
#       val = [A[i,j] + B[i,j]] # It isn't able to prove/guarantee 
#                               # at compile-time that the array's 
#                               # size will always be a given value, 
#                               # and thus it allocates it to the heap.
#       C[i,j] = val[1]
#     end
#   end
#   @btime inner_alloc!(C,A,B)

# function inner_noalloc!(C,A,B)
#     for j in 1:100, i in 1:100
#       val = A[i,j] + B[i,j] # scalar value of size float64
#       C[i,j] = val[1]
#     end
#   end
#   @btime inner_noalloc!(C,A,B)

# using StaticArrays
# function static_inner_alloc!(C,A,B)
#   for j in 1:100, i in 1:100
#     val = @SVector [A[i,j] + B[i,j]] # get statically-sized arrays and 
#                                      # thus arrays which are stack-allocated:
#     C[i,j] = val[1]
#   end
# end
# @btime static_inner_alloc!(C,A,B)

# function inner_noalloc!(C,A,B)
#     for j in 1:100, i in 1:100
#       val = A[i,j] + B[i,j] 
#       C[i,j] = val[1] # C has already been allocated we are just 
#                       # mutating the values this is a great Idea
#                       # if we know that further operations are done 
#                       # on same sized arrays
#     end
#   end
#   @btime inner_noalloc!(C,A,B)

#=
In julia functions which mutate the first value are conventionally 
noted by a !.
=#

# function inner_alloc(A,B)
#     C = similar(A) # no mutation hence take more time as new 
#                    # memory is being allocated
#     for j in 1:100, i in 1:100
#       val = A[i,j] + B[i,j]
#       C[i,j] = val[1]
#     end
#   end
#   @btime inner_alloc(A,B) 

# function unfused!(tmp, A, B, C)
#     tmp = A .+ B .+ C
# end
# tmp = similar(A)
# @btime unfused!(tmp, A, B, C);

# D = similar(A)
# fused!(D,A,B,C) = (D .= A .+ B .+ C)
# @btime fused!(D,A,B,C);

# however for julia vectorized or non-vetorised should not matter
# but it does because of something called as checking bounds for array

# function vetorized!(tmp, A, B, C)
#     tmp .= A .* B .* C
#     nothing
# end

# function non_vectorized!(tmp, A, B, C)
#     for i in 1:lastindex(tmp)
#         tmp[i] = A[i] * B[i] * C[i]
#     end
#     nothing
# end

# tmp = similar(A)

# @btime vetorized!(tmp,A,B,C)
# @btime non_vectorized!(tmp,A,B,C)

#A[100001] error-> boundschecking
# Maybe it does not matter now as the code works the same probably with new julia
# this might have been soughted out

# @btime A[1:5,1:5] # produces copies 
# @btime @view A[1:5,1:5] # produces pointer to the memory thus less memory 
# However as we access the memory we can change the value therefore need to be 
# carefull

# function ff7(A)
#     A[1:5,1:5]
#     nothing
# end


# function ff8(A)
#     @view A[1:5,1:5]
#     nothing
# end

# @btime ff7(A)
# @btime ff8(A)

#=
Julia JIT compiles function calls and if we put our codes inside
function then it will run its optimizations on the whole function
Therefor to write faster codes just use more functions
=#


#=
Optimizing Memory Use Summary
Avoid cache misses by reusing values

Iterate along columns

Avoid heap allocations in inner loops

Heap allocations occur when the size of things is not proven at compile-time

Use fused broadcasts (with mutated outputs) to avoid heap allocations

Array vectorization confers no special benefit in Julia because Julia loops are as fast as C or Fortran

Use views instead of slices when applicable

Avoiding heap allocations is most necessary for O(n) algorithms or algorithms with small arrays

Use StaticArrays.jl to avoid heap allocations of small arrays in inner loops
=#