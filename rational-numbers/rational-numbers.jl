import Base: +, -, *, /, ^, ==, <, >, <=, >=, zero, one, abs, inv, show

struct RationalNumber{T<:Integer} <: Real
    n::T
    d::T
    RationalNumber(::Type{T}, n, d) where {T} = new{T}(n, d)
end

RationalNumber(n::T, d::T) where {T<:Integer} = RationalNumber{T}(n, d)
RationalNumber(n::Integer, d::Integer) = RationalNumber(promote(n, d)...)
RationalNumber(n::Integer) = RationalNumber(n, one(n))

function RationalNumber{T}(n::Integer, d::Integer) where {T<:Integer}
    iszero(d) && iszero(n) && throw(ArgumentError("Invalid rational"))
    if signbit(d)
        n, d = -n, -d
    end
    n, d = reduce_ratio(n, d)
    RationalNumber(T, T(n), T(d))
end

function reduce_ratio(p::Integer, q::Integer)
    d = gcd(p, q)
    p ÷ d, q ÷ d
end

numerator(r::RationalNumber) = r.n
denominator(r::RationalNumber) = r.d

zero(::Type{RationalNumber{T}}) where {T<:Number} = RationalNumber{T}(0, 1)
one(::Type{RationalNumber{T}}) where {T<:Number} = RationalNumber{T}(1, 1)

abs(r::RationalNumber) = RationalNumber(abs(r.n), abs(r.d))
inv(r::RationalNumber) = RationalNumber(r.d, r.n)

+(r::RationalNumber) = RationalNumber(+r.n, r.d)
-(r::RationalNumber) = RationalNumber(-r.n, r.d)

+(a::RationalNumber, b::RationalNumber) = RationalNumber(a.n * b.d + a.d * b.n, a.d * b.d)
-(a::RationalNumber, b::RationalNumber) = RationalNumber(a.n * b.d - a.d * b.n, a.d * b.d)
*(a::RationalNumber, b::RationalNumber) = RationalNumber(a.n * b.n, a.d * b.d)
/(a::RationalNumber, b::RationalNumber) = a * inv(b)

ntrt(x::Number, n::Integer) = x^(1/n)

^(r::RationalNumber, x::Number) = r.n^x / r.d^x
^(x::Number, r::RationalNumber) = ntrt(x^float(r.n), r.d)

function ^(r::RationalNumber, x::Integer)
    if signbit(x)
        x = abs(x)
        return RationalNumber(r.d^x, r.n^x)
    end
    RationalNumber(r.n^x, r.d^x)
end

==(a::RationalNumber, b::RationalNumber) = a.n == b.n && a.d == b.d
<=(a::RationalNumber, b::RationalNumber) = a.d == b.d ? a.n <= b.n : a.n * b.d <= a.d * b.n
<( a::RationalNumber, b::RationalNumber) = a.d == b.d ? a.n <  b.n : a.n * b.d <  a.d * b.n

==(r::RationalNumber, x::Integer) = r.d == 1 && r.n == x
==(x::Integer, r::RationalNumber) = r == x
<=(r::RationalNumber, x::Integer) = r.n <= x*r.d
<=(x::Integer, r::RationalNumber) = x*r.d <= r.n
<( r::RationalNumber, x::Integer) = r.n < x*r.d
<( x::Integer, r::RationalNumber) = x*r.d < r.n

==(r::RationalNumber, x::AbstractFloat) = r.n/r.d == x
==(x::AbstractFloat, r::RationalNumber) = r == x
<=(r::RationalNumber, x::AbstractFloat) = r.n/r.d <= x
<=(x::AbstractFloat, r::RationalNumber) = x <= r.n/r.d
<( r::RationalNumber, x::AbstractFloat) = r.n/r.d < x
<( x::AbstractFloat, r::RationalNumber) = x < r.n/r.d

show(io::IO, r::RationalNumber) = print(io, "$(r.n)//$(r.d)")
