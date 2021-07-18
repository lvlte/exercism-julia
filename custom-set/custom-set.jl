import Base: iterate, in, isempty, length, ==, delete!, show

struct CustomSet{T} <: AbstractSet{T}
    el::Dict{Any, Nothing} # use dict keys for uniqueness

    CustomSet{Any}() = new{Any}(Dict{Any, Nothing}())
    CustomSet{Any}(el::Dict{Any, Nothing}) = new{Any}(el)
end

CustomSet() = CustomSet{Any}()
CustomSet(A::AbstractVector) = CustomSet{Any}(Dict{Any, Nothing}(A .=> nothing))

CustomSet(X::T...) where {T} = CustomSet([ X[i] for i in 1:length(X) ])
CustomSet(set::CustomSet) = CustomSet(keys(set.el)...)

iterate(set::CustomSet{Any}) = iterate(keys(set.el))
iterate(set::CustomSet{Any}, i...) = iterate(keys(set.el), i...)

# for ... in
in(set::CustomSet) = x -> x in keys(set.el)

isempty(set::CustomSet) = isempty(set.el)
length(set::CustomSet) = length(set.el)
in(x, set::CustomSet) = haskey(set.el, x)

==(a::CustomSet, b::CustomSet) = a.el == b.el

copy(set::CustomSet) = CustomSet(set)
push!(set::CustomSet, x) = (set.el[x] = nothing; set)
delete!(set::CustomSet, x) = (delete!(set.el, x); set)

function disjoint(a::CustomSet, b::CustomSet)
    if length(b) < length(a)
        a, b = b, a
    end
    !any(x -> x ∈ b, a)
end

function filter!(f, set::CustomSet)
    for x in set
        !f(x) && delete!(set, x)
    end
    set
end

function union!(a::CustomSet, b::CustomSet)
    for x in b
        push!(a, x)
    end
    a
end

union(a::CustomSet, b::CustomSet) = union!(copy(a), b)

complement!(a::CustomSet, b::CustomSet) = filter!(x -> x ∉ b, a)
complement(a::CustomSet, b::CustomSet) = CustomSet([ x for x in a if x ∉ b ])

intersect!(a::CustomSet, b::CustomSet) = filter!(x -> x ∈ b, a)

function intersect(a::CustomSet, b::CustomSet)
    if length(b) < length(a)
        a, b = b, a
    end
    CustomSet([ x for x in a if x ∈ b ])
end

function show(io::IO, set::CustomSet)
    if isempty(set)
        print(io, "CustomSet()")
    else
        print(io, "CustomSet(")
        print(io, "$(keys(set.el))")
        print(io, ')')
    end
end

show(io::IO, ::MIME"text/plain", set::CustomSet) = show(io, set)
