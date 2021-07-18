mutable struct Keygen
    keystore::Dict{Int64, Nothing}
    alphabet::Vector{Char}
    nletters::Int64
    ndigits::Int64
    entropy::Int64

    function Keygen(abc::Vector{Char}, nl::Int, nd::Int)
        new(Dict{Int64, Nothing}(), abc, nl, nd, length(abc)^nl * 10^nd)
    end
end

Keygen(az::StepRange{Char, Int}, nl::Int, nd::Int) = Keygen([ l for l in az ], nl, nd)
Keygen(nl::Int, nd::Int) = Keygen('A':'Z', nl, nd)

function generate_key(k::Keygen)
    if length(k.keystore) >= k.entropy
        throw(ErrorException("no more keys!"))
    end

    abc = length(k.alphabet)
    chr = [ Int(floor(rand()*Int(time_ns()))) % abc for i in 1:k.nletters ]
    n = Int(floor(rand()*Int(time_ns()))) % 10^k.ndigits

    key = sum(c*abc^(i-1) for (i,c) in enumerate(chr)) + n
    while haskey(k.keystore, key)
        key = (key + 1) % k.entropy
    end

    return key, chr, n
end

###

const alphabet = 'A':'Z'
const nletters = 2
const ndigits = 3

const keygen = Keygen(alphabet, nletters, ndigits)

###

mutable struct Robot
    name::Union{String}
    key::Union{Int64,Nothing}

    Robot() = new("")
end

reset!(robot::Robot) = (unregister!(robot) ; robot)

function name(robot::Robot)
    if isempty(robot.name)
        register!(robot)
    end
    robot.name
end

function register!(robot::Robot)
    key, chr, n = generate_key(keygen)
    keygen.keystore[key] = nothing
    robot.key = key
    robot.name = join(keygen.alphabet[c+1] for c in chr) * lpad(n, 3, "0")
end

function unregister!(robot::Robot)
    delete!(keygen.keystore, robot.key)
    robot.name = ""
    robot.key = nothing
end
