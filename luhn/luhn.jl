function luhn(str::AbstractString)::Bool
  s = replace(str, " " => "")
  if (slen = length(s)) < 2 || occursin(r"[^0-9]", s)
    return false
  end
  d1 = [parse(Int, s[d]) for d in slen:-2:1]
  d2 = [(n = parse(Int, s[d])*2) > 9 ? n-9 : n for d in slen-1:-2:1]
  sum([d1 ; d2]) % 10 === 0
end
