using Dates

struct ClHour <:Number
    value::Int8
    ClHour(h::Number) = h in 0:23 ? new(h) : throw(DomainError(h, "Hours must be in range 0:23"))
end

struct ClMinute <:Number
    value::Int8
    ClMinute(m::Number) = m in 0:59 ? new(m) : throw(DomainError(m, "Minutes must be in range 0:59"))
end

struct Clock
    hours::ClHour
    minutes::ClMinute
end

function Clock(h::Number, m::Number)
    mh = m ÷ 60 - ( m % 60 < 0 ? 1 : 0)
    h = ((h + mh) % 24 + 24) % 24
    m = (m % 60 + 60) % 60
    return Clock(ClHour(h), ClMinute(m))
end

Clock(h::ClHour, m::Number) = Clock(h.value, m)
Clock(h::Number, m::ClMinute) = Clock(h, m.value)

# Clock() +/- Dates.Minute()
Base.:(+)(x::Clock, y::Dates.Minute) = Clock(x.hours.value, x.minutes.value + y.value)
Base.:(+)(x::Dates.Minute, y::Clock) = y + x
Base.:(-)(x::Clock, y::Dates.Minute) = Clock(x.hours.value, x.minutes.value - y.value)

# Implement show(::Clock)
function Base.show(io::IO, clock::Clock)
    hh = lpad(clock.hours.value, 2, "0")
    mm = lpad(clock.minutes.value, 2, "0")
    show(io, "$hh:$mm")
end

# Verbose show(::Clock)
function Base.show(io::IO, ::MIME"text/plain", clock::Clock)
    get(io, :compact, false) && return show(io, clock)
    println(io, "Clock: ", clock.hours, ", ", clock.minutes)
    print(io, " ", clock)
end

# # Required with `mutable` structure (otherwise `@test` macro expansion fails)
# Base.:(==)(x::Clock, y::Clock) = x.hours == y.hours && x.minutes == y.minutes
# Base.:(==)(x::ClHour, y::ClHour) = x.value == y.value
# Base.:(==)(x::ClMinute, y::ClMinute) = x.value == y.value
