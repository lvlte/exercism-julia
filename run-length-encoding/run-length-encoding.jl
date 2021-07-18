function encode(s)
    out = ""
    for m in eachmatch(r"(.)\1+|.", s)
        out *= m.captures[1] === nothing ? m.match : string(length(m.match), m.captures[1])
    end
    return out
end


function decode(s)
    out = ""
    for m in eachmatch(r"(\d+)(\D)|.", s)
        out *= m.captures[1] === nothing ? m.match : m.captures[2]^parse(Int, m.captures[1])
    end
    return out
end
