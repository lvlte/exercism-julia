using OrderedCollections

const rom1 = LittleDict(1000 => 'M', 100 => 'C', 10 => 'X', 1 => 'I')
const rom5 = Dict(500 => 'D', 50 => 'L', 5 => 'V')
const romans = merge(rom1, rom5)

function to_roman(number::Int)
  number < 1 && throw(ErrorException("number must be a positive integer"))
  output = ""
  for (n, l) in rom1
    r  = number % 10n ÷ n
    nr = n*r
    if r in 1:3
      output *= l^r
    elseif r in [4, 9]
      output *= l * romans[nr + n]
    elseif r != 0
      output *= r == 5 ? rom5[nr] : rom5[5n] * l^(r - 5)
    end
  end
  return output
end
