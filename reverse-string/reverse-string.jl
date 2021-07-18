using Unicode

const TEST_GRAPHEMES = true

function myreverse(s::AbstractString)::String
    (join ∘ reverse ∘ collect)(graphemes(s))
end
