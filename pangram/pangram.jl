"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
ispangram(input) = 'a':'z' ⊆ lowercase(input)

# issubset(a, b) is equivalent to :
#  a ⊆ b or ⊆(a, b)
#  b ⊇ a or ⊇(b, a)
