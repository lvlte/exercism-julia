import Base: +, -, *, /, //, ==, real, abs, exp, show

struct ComplexNumber{T<:Real} <: Number
    r::T
    i::T
end

# Types / Promotion
ComplexNumber(x::Real, y::Real) = ComplexNumber(promote(x, y)...)
ComplexNumber(x::Real) = ComplexNumber(x, zero(x))

ComplexNumber{T}(x::Real) where {T<:Real} = ComplexNumber{T}(x, 0)
ComplexNumber{T}(z::ComplexNumber) where {T<:Real} = ComplexNumber{T}(real(z), imag(z))

# Basic functions
real(z::ComplexNumber) = z.r
imag(z::ComplexNumber) = z.i

conj(z::ComplexNumber) = ComplexNumber(real(z), -imag(z))
abs(z::ComplexNumber) = hypot(real(z), imag(z))
abs2(z::ComplexNumber) = z * conj(z)
inv(z::ComplexNumber) = ComplexNumber(real(z), -imag(z)) / (real(z)^2 + imag(z)^2)

# Revert sign
+(z::ComplexNumber) = ComplexNumber(+real(z), +imag(z))
-(z::ComplexNumber) = ComplexNumber(-real(z), -imag(z))

# Arithmetic
+(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z) + real(w), imag(z) + imag(w))
-(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z) - real(w), imag(z) - imag(w))
*(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z)*real(w) - imag(z)*imag(w), real(z)*imag(w) + imag(z)*real(w))
/(z::ComplexNumber, w::ComplexNumber) = z * inv(w)

# Mixing real and complex numbers
+(x::Real, z::ComplexNumber) = ComplexNumber(x + real(z), imag(z))
+(z::ComplexNumber, x::Real) = x + z
-(z::ComplexNumber, x::Real) = ComplexNumber(real(z) - x, imag(z))
-(x::Real, z::ComplexNumber) = x + (-z)
*(x::Real, z::ComplexNumber) = ComplexNumber(x * real(z), x * imag(z))
*(z::ComplexNumber, x::Real) = x * z
/(z::ComplexNumber, x::Real) = ComplexNumber(real(z)/x, imag(z)/x)

# Equality (Base.:≈ and isapprox() work using equality on normalized value)
==(z::ComplexNumber, w::ComplexNumber) = real(z) == real(w) && imag(z) == imag(w)
==(z::ComplexNumber, x::Real) = isreal(z) && real(z) == x
==(x::Real, z::ComplexNumber) = ==(z, x)

# Natural base exponential e^z
exp(z::ComplexNumber) = exp(real(z)) * ComplexNumber(cos(imag(z)), sin(imag(z)))

# Imaginary constant (amounts to 0 + 1*i, the use of boolean allows to recognize
# `jm` identity, ie. show() implementation below).
const jm = ComplexNumber(false, true)

# Pretty print
show(io::IO, z::ComplexNumber{Bool}) = print(io, z == jm ? "jm" : "ComplexNumber($(z.r),$(z.i))")

function show(io::IO, z::ComplexNumber)
    r, i = real(z), imag(z)
    show(io, r)
    if signbit(i) && !isnan(i)
        print(io, " - ")
        show(io, -i)
    else
        print(io, " + ")
        show(io, i)
    end
    if !(isa(i, Integer) && !isa(i, Bool) || isa(i, AbstractFloat) && isfinite(i))
        print(io, "*")
    end
    print(io, "jm")
end
