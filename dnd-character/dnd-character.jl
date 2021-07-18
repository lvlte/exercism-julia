ability() = sum(sort([ rand(1:6) for i in 1:4])[2:end])
modifier(ability) = floor((ability-10) / 2)

mutable struct DNDCharacter
    strength::Int8
    dexterity::Int8
    constitution::Int8
    intelligence::Int8
    wisdom::Int8
    charisma::Int8
    hitpoints::Int8

    function DNDCharacter()
        a = [ ability() for i in 1:6 ]
        new(a..., 10 + modifier(a[3]))
    end
end
