const d = Dict(
  "eggs"          => 1,
  "peanuts"       => 2,
  "shellfish"     => 4,
  "strawberries"  => 8,
  "tomatoes"      => 16,
  "chocolate"     => 32,
  "pollen"        => 64,
  "cats"          => 128
)

function allergic_to(score, allergen)
  score | d[allergen] == score
end

function allergy_list(score)
  Set( al for (al,x) in d if allergic_to(score, al) )
end
