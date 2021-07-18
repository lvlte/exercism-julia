"""Calculate the number of grains on square `square`."""
function on_square(square)
    check(square) && return Int128(2)^(square - 1)
end

"""Calculate the total number of grains after square `square`."""
function total_after(square)
    check(square) && return Int128(2)^square - 1
end

function check(square)
    1 <= square <= 64 || throw(DomainError(square, "square out of range [1, 64]"))
end
