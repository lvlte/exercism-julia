"Calculate the Hamming Distance between two DNA strands."
function distance(a, b)
    length(a) != length(b) && throw(ArgumentError("a and b have different lengths"))
    count(collect(a) .!= collect(b))
end
