function spiral_matrix(mn::Int)::Matrix{Int}
    mn > 0 || return Matrix{Int}(undef, 0, 0)

    m = vcat(reshape(1:mn, 1, :), zeros(Int, mn-1, mn))
    n, l = mn + 1, mn - 1
    i, j = 1, 2:mn

    function fill_row(idx_inc)
        m = rotl90(m)
        if m[i, j.:start] != 0
            i, j = idx_inc(i, j)
        end
        m[i, j] = reshape(n:n+l-1, 1, l)
        n += l
    end

    while l > 0
        fill_row((i,j) -> (i, j.:start+1:j.:stop+1))
        fill_row((i,j) -> (i + 1, j))
        j = j.:start:j.:stop - 1
        l -= 1
    end

    isodd(mn) ? m : rot180(m)
end
