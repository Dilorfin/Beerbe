local item = {
    id = 4,
    title = "Medium potion",
    type = "potion",
    health = 50,
    mana = 50
}

function item:use(character)
    character.health = character.health + item.health
    if character.health > character:getMaxHealth() then
        character.health = character:getMaxHealth()
    end

    character.mana = character.mana + item.mana
    if character.mana > character:getMaxMana() then
        character.mana = character:getMaxMana()
    end
end

return item