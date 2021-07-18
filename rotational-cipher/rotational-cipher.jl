function rotate(shift::Int, c::Char)::Char
    if c in ['a':'z' ; 'A':'Z']
        i = Int(c)|32 - 97
        return c + (i+shift)%26 - i
    end
    return c
end

function rotate(shift::Int, text::String)::String
    replace(c -> rotate(shift, c), collect(text)) |> join
end

for i in 1:26
    R = Symbol("R", i, "_str")
    @eval macro $R(str) rotate($i, str) end
end
