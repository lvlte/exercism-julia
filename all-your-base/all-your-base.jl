check_base(b) = b > 1 || throw(DomainError(b, "base must be greater than one"))

function all_your_base(digits, base_in, base_out)
  to_base(from_base(digits, base_in), base_out)
end

function from_base(digits, b)
  check_base(b)
  reduce((n,d) -> (d in 0:b-1 || throw(DomainError(d)); b*n + d), digits, init=0)
end

function to_base(n, b)
  check_base(b) && n >= 0 || throw(DomainError(b, "n must be a positive integer"))
  a = []
  while n > 0
    n, rem = divrem(n, b)
    pushfirst!(a, rem)
  end
  isempty(a) ? [0] : a
end
