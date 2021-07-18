function collatz_steps(n::Int)
    n < 1 && throw(DomainError(n, "n must be a positive integer"))
    step = 0
    while n > 1
        step += 1
        n = iseven(n) ? n ÷ 2 : 3n + 1
    end
    return step
end
