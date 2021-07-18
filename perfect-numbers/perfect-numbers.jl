using Primes

function divisors(n::Integer)::Vector{Int}
  n < 0 && return divisors(-n)
  n > 1 || return []
  d = [1]
  for (k, v) in factor(n)
    d = reshape(d*[k^i for i in 0:v]', length(d)*(v+1))
  end
  sort(d)[1:end-1]
end

function aliquot(n::Integer)::Int
  n > 0 || throw(DomainError(n, "n must be a positive integer"))
  return (sum ∘ divisors)(n)
end

isperfect(n::Integer)::Bool = aliquot(n) == n
isabundant(n::Integer)::Bool = aliquot(n) > n
isdeficient(n::Integer)::Bool = aliquot(n) < n
