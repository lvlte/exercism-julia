function triangle(n)
    n < 0 && throw(DomainError(n, "n must be a positive integer"))
    [[binomial(_n, k) for k in 0:_n] for _n in 0:n-1]
end

