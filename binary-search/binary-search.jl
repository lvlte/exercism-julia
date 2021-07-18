function binarysearch(A, val; rev::Bool=false, lt::Function=<, by::Function=v->v)
    isempty(A) && return 1:0

    val = by(val)
    lt = rev ⊻ (lt == >) ? (>) : (<)

    start = 1
    stop = length(A)
    pivot = 0

    while start <= stop
        pivot = (start + stop) ÷ 2
        if by(A[pivot]) == val
            return pivot:pivot
        elseif lt(A[pivot], val)
            start = pivot + 1
        else
            stop = pivot - 1
        end
    end

    return start:stop
end
