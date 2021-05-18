local item = {
    id = 2,
    title = "Small potion",
    type = "potion",
    health = 10,
    mana = 10
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