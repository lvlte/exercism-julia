const d = Dict(3 => "Pling", 5 => "Plang", 7 => "Plong")

function raindrops(number)
    output = ""
    for n in [3, 5, 7]
        number % n == 0 && (output *= d[n])
    end
    return isempty(output) ? string(number) : output
end
