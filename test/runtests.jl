using Myexample
using Test

@test g(2.0) ≈ h(2.0)

@testset "Myexample.jl" begin
    @test g(2.0) ≈ h(2.0)
end
