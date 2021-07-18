function sieve(limit::Integer)
    primes = trues(limit)
    primes[1] = false
    for n in 2:limit, m in n^2:n:limit
        primes[m] = false
    end
    findall(primes)
end

# trues() returns a BitArray -> 8x space efficiency over Array{Bool, N}

# Start with n=2 : n is prime
# then for each multiples m in range n²:n:limit, set m not prime

# Why range n²:n:limit
# Because all 2n's are obviously multiples of 2, and because for n = 2: n² = 2n
# Then for n = 3, we already got the 2n's (including 3*2) => start at 3*3
# Then for n = 5, we already got the 2n's (5*2, 5*2*2) the 3n's (5*3) => start at 5*5
# ...
