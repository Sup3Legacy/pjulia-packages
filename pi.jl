include("random.jl")

"""Approximates Pi using the Monte-Carlo method over n iterations."""
function monte_carlo(n :: Int64) :: Float64
    p = 0
    for i = 0 : (n - 1)
        x = random::rand()
        y = random::rand()
        if (x * x + y * y < 1.)
            p = p + 1
        end
    end
    return div(4 * p + 0., n + 0.)
end