function acronym(s::AbstractString)::String
  em = eachmatch(r"(?<![a-zA-Z'])([a-zA-Z])", s)
  em === nothing ? s : uppercase(join(m.captures[1] for m in em))
end
