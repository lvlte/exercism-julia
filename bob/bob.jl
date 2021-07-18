function bob(stimulus)
    s = strip(stimulus)
    if isempty(s)
        return "Fine. Be that way!"
    end
    yelling = uppercase(s) == s && match(r"[A-Z]+", s) !== nothing
    if s[end] == '?'
        return yelling ? "Calm down, I know what I'm doing!" : "Sure."
    end
    return yelling ? "Whoa, chill out!" : "Whatever."
end
