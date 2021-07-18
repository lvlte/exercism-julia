function is_equilateral(sides::Vector{T}) where T <: Number
  a, b, c = sides
  return a == b == c != 0
end

function is_isosceles(sides::Vector{T}) where T <: Number
  0 in sides && return false
  a, b, c = sort(sides)
  return a == b && a+b > c || b == c && b+c > a
end

function is_scalene(sides::Vector{T}) where T <: Number
  0 in sides && return false
  a, b, c = sides
  abs(a-b) < c < a+b && allunique(sides)
end
