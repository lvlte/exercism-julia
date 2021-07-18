function wordcount(sentence)
    d = Dict()
    for m in eachmatch(r"[0-9a-z]+'[0-9a-z]+|[0-9a-z]+", lowercase(sentence))
        d[m.match] = haskey(d, m.match) ? d[m.match] + 1 : 1
    end
    return d
end
