import Base: ==, show

const NORTH = Complex( 0,  1)
const EAST  = Complex( 1,  0)
const WEST  = Complex(-1,  0)
const SOUTH = Complex( 0, -1)

mutable struct Point{T<:Integer}
    x::T
    y::T

    Point{T}(x, y) where {T<:Integer} = new{T}(x, y)
end

Point(x::T, y::T) where {T<:Integer} = Point{T}(x, y)
Point(coord::Tuple{T,T}) where {T<:Integer} = Point(coord...)

==(a::Point{T}, b::Point{T}) where {T<:Integer} = a.x == b.x && a.y == b.y


mutable struct Robot
    coord::Point
    dir::Complex

    Robot(c::Point{T}, d::Complex{T}) where {T<:Integer} = new(c, d)
end

Robot(coord::Tuple{T,T}, dir::Complex{T}) where {T<:Integer} = Robot(Point(coord), dir)
Robot(x::T, y::T, dir::Complex{T}) where {T<:Integer} = Robot(Point(x, y), dir)

position(r::Robot) = r.coord
heading(r::Robot) = r.dir

turn_right!(r::Robot) = (r.dir *= (-im) ; r)
turn_left!(r::Robot) = (r.dir *= im ; r)

function advance!(r::Robot)
    dx, dy = reim(r.dir)
    r.coord.x += dx
    r.coord.y += dy
    r
end

const moves = Dict('A' => advance!, 'L' => turn_left!, 'R' => turn_right!)
move!(r::Robot, str::AbstractString) = ([moves[m](r) for m in collect(str)] ; r)

show(io::IO, ::Robot) = print("Robot(>•_•)")
