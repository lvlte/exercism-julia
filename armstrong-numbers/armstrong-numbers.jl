
function isarmstrong(n::Int, base::Int=10)::Bool
  n < base && return true
  k = floor(log(base, n)) + 1
  sum(i -> ((n%base^(i+1) - n%base^i) ÷ base^i)^k, 0:k-1) == n
end

# isarmstrong(n) = n == sum(digits(n).^ndigits(n))
