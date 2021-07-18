function trinary_to_decimal(str::AbstractString)::Int
  occursin(r"[^0-2]", str) && return 0
  sum(parse(Int, n)*3^(i-1) for (i, n) in enumerate(str[end:-1:1]))
end
