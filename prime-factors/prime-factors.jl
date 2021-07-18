
function least_factor(n::Int)::Int
    n % 2 == 0 && return 2
    for i in 3:2:isqrt(n)
        n % i == 0 && return i
    end
    return n
end

function prime_factors(n::Int)::Vector{Int}
    isnan(n) || !isfinite(n) && return [n];
    n % 1 != 0 && return []
    n < 0 && return map(n -> -n, prime_factors(-n));
    factors = []
    while n > 1
        f = least_factor(n)
        push!(factors, f)
        n = n ÷ f
    end
    return factors
end
