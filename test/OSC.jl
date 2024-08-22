A = rand(100,100)
B = rand(100,100)
C = rand(100,100)
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

