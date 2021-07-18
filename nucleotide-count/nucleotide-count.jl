"""
    count_nucleotides(strand)

The frequency of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    ret = Dict(i => 0 for i in "ACGT")
    for nuc in strand
        nuc in "ACGT" || throw(DomainError(nuc, "Invalid DNA sequence"))
        ret[nuc] += 1
    end
    ret
end
