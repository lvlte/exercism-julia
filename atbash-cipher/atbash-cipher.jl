const d = Dict(['0':'9' ; 'A':'Z'; 'a':'z'...] .=> ['0':'9' ; 'z':-1:'a'; 'z':-1:'a'...])

function encode(input::AbstractString, group::Int=5, offset::Int=0)
    group = group == 0 ? Inf : group
    replace(split(input, "")) do c
        if haskey(d, c[1])
            return (offset += 1) % group === 0 ? string(d[c[1]]) * " " : string(d[c[1]])
        end
        return ""
    end |> join |> strip
end

function decode(input::AbstractString)
    replace(c -> haskey(d, c[1]) ? string(d[c[1]]) : "", split(input, "")) |> join
end
