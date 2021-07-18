function to_rna(dna)
    pairs = Dict("G" => "C", "C" => "G", "T" => "A", "A" => "U")
    return replace(dna, r"." => s -> get(pairs, s, 0) != 0 ? pairs[s] : (throw(ErrorException("Invalid DNA sequence"))))
end
