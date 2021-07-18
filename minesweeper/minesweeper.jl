
function adj_to(i::Int, j::Int, mx::Int, my::Int)
  xs, ys = max(i-1,1):min(i+1,mx), max(j-1,1):min(j+1,my)
  vec([ (x,y) for x in xs, y in ys ])
end

function annotate(minefield::Vector)
  if (isempty(minefield) || isempty(minefield[1]))
    return minefield
  end

  mx, my = length(minefield), length(minefield[1])
  out = map(str -> collect(str), minefield)

  for i in 1:mx, j in 1:my
    minefield[i][j] == '*' && continue
    adj = [ minefield[x][y] for (x,y) in adj_to(i, j, mx, my) ]
    n = count(c -> c == '*', adj)
    out[i][j] = n != 0 ? n+48 : ' '
  end

  map(row -> join(row), out)
end
