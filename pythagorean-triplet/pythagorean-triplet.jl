function pythagorean_triplets(p::Int)
    triplets = []
    limit = Int(ceil(sqrt(p/2)))
    for n in 1:limit, m in n+1:limit
        gcd(m, n) == 1 && !all(isodd.([m, n])) || continue
        a, b, c = m^2 - n^2, 2m*n, m^2 + n^2
        s = sum([a, b, c])
        d, r = divrem(p, s)
        r == 0 && push!(triplets, Tuple(sort([a*d, b*d, c*d])))
    end
    return sort(triplets)
end
