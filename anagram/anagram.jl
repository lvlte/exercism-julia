using DataStructures

function detect_anagrams(subject, candidates)
    s = lowercase(subject)
    sc = counter(s)
    filter(c -> (c = lowercase(c)) != s && counter(c) == sc, candidates)
end
