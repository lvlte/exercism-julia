function transform(input::AbstractDict)
    Dict(Char(Int(c)|32) => n for (n, l) in input for c in l)
end
