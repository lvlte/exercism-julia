function clean(phone_number)
  s = split(phone_number, r"[\s\-().+]", keepempty=false)
  if length(s) == 4 && s[1] != "1" || length(s) ∉ [1,3,4]
    return nothing
  end
  m = match(r"^1?([2-9][\d]{2}[2-9][\d]{2}[\d]{4})$", join(s))
  return m !== nothing ? m.captures[1] : m
end
