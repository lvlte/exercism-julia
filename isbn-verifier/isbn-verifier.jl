import Base: string, show

struct ISBN <: AbstractString
    value::String

    function ISBN(str::AbstractString)
        m = match(r"^\d{9}[0-9xX]$", replace(str, "-" => ""))
        if m !== nothing
            n = sum(parse(Int, m.match[i]) * (11-i) for i in 1:9)
            n += m.match[10] ∈ '0':'9' ? parse(Int, m.match[10]) : 10
            n % 11 == 0 && return new(m.match)
        end
        throw(DomainError(str, "\n(╯°□°)╯ ︵ ┻━┻\n"))
    end
end

function isvalid(::Type{ISBN}, str::AbstractString)::Bool
    try
        s = ISBN(str)
    catch e
        isa(e, DomainError) || rethrow(e)
        return false
    end
    return true
end

string(str::ISBN) = str.value

macro isbn_str(str::AbstractString) :( ISBN($str).value ) end

show(io::IO, str::ISBN) = print(io, "ISBN($(str.value))")
show(io::IO, ::MIME"text/plain", str::ISBN) = show(io, str)
