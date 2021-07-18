const d = merge(
  Dict(['a','e','i','o','u','l','n','r','s','t']  .=> 1),
  Dict(['d','g']                                  .=> 2),
  Dict(['b','c','m','p']                          .=> 3),
  Dict(['f','h','v','w','y']                      .=> 4),
  Dict(['k']                                      .=> 5),
  Dict(['j','x']                                  .=> 8),
  Dict(['q','z']                                  .=> 10)
)

function score(str)
  sum([c in 'a':'z' ? d[c] : 0 for c in collect(lowercase(str))])
end
