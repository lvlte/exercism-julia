const d = Dict('(' => ')', '[' => ']', '{' => '}')
const drev = Dict(v => k for (k,v) in d)

const sub = Dict(
  "\\\\left"  => "(",
  "\\\\right" => ")",
  "\\\\begin" => "(",
  "\\\\end"   => ")"
)

function matching_brackets(s::AbstractString)::Bool
  replace(s, Regex("$(join(keys(sub),'|'))") => m -> sub["\\"*m])
  brackets = []
  for c in collect(s)
    if haskey(d, c)
      push!(brackets, c)
    elseif haskey(drev, c)
      !isempty(brackets) && last(brackets) == drev[c] || return false
      pop!(brackets)
    end
  end
  isempty(brackets)
end
