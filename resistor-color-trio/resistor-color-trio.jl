
const RMAP = Dict(
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9,
)

function label(colors::Vector{String})::String
    d1, d2, p = [ RMAP[c] for c in colors ]
    Ω = (d1*10 + d2)*10^(p)
    Ω % 1000 == 0 ? string(Ω÷1000) * " kiloohms" : string(Ω) * " ohms"
end
