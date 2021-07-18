enable_bonus_tests = true

import Base: show, length, isempty, iterate, in, first, last, size, ==, empty!,
    push!, pushfirst!, append!, pop!, popfirst!, size, getindex, setindex!

mutable struct CircularBuffer{T} <: AbstractVector{T}
    items::Vector{T}
    capacity::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        new{T}(T[], capacity)
    end
end

CircularBuffer(capacity::Integer) = CircularBuffer{Any}(capacity)

==(cb::CircularBuffer, v::AbstractVector) = cb.items == v

iterate(cb::CircularBuffer) = iterate(cb.items)
iterate(cb::CircularBuffer, i...) = iterate(cb.items, i...)

in(cb::CircularBuffer) = x -> x in keys(cb.items)

for fname in (:isempty, :length, :first, :last, :size)
    @eval ($fname(cb::CircularBuffer) = $fname(cb.items))
end

capacity(cb::CircularBuffer) = cb.capacity
isfull(cb::CircularBuffer) = length(cb) == cb.capacity

in(x, cb::CircularBuffer) = in(x, cb.items)

getindex(cb::CircularBuffer, i::Int) = getindex(cb.items, i)
setindex!(cb::CircularBuffer, x, i::Int) = setindex!(cb.items, x, i)

empty!(cb::CircularBuffer) = (empty!(cb.items) ; cb)

function append!(cb::CircularBuffer, iter; overwrite::Bool=false)
    [ push!(cb, x; overwrite) for x in iter ]
    return cb
end

for (f1, f2) in ((:push!, :popfirst!), (:pushfirst!, :pop!))
    @eval begin
        function $f1(cb::CircularBuffer, item; overwrite::Bool=false)
            if isfull(cb)
                overwrite ? $f2(cb.items) : throw(BoundsError(cb.items, cb.capacity))
            end
            $f1(cb.items, item)
            return cb
        end
    end
end

for fname in (:pop!, :popfirst!)
    @eval begin
        function $fname(cb::CircularBuffer)
            length(cb) == 0 && throw(BoundsError(cb.items, 0))
            $fname(cb.items)
        end
    end
end

function summary(cb::CircularBuffer)
    "$(length(cb))-element CircularBuffer{$(eltype(cb))}($(cb.capacity))"
end

summary(io::IO, cb::CircularBuffer) = print(io, summary(cb))

function show(io::IO, cb::CircularBuffer)
    show(io, cb.items)
end
