local character = {
	
	position = {
		world_seed = nil,
		room = 1,
		x = 0,
		y = 0
	},

	-- current values
    health = 5,
	mana = 5,
	
	-- usages numbers
    passive_skills = {
		health = 1,
		mana = 1
	},
    active_skills = {
        thunder = 0
	},

	bag = { 1 }, -- index from items table
	equipped = {
		right_hand = 1 -- index from bag
	}
}
--[[
UnitStats = {
    health
    mana
    attack
    magic
    defense
}
]]

function character:getMaxHealth()
	return 5 * self.passive_skills.health
end

function character:getMaxMana()
	return 5 * self.passive_skills.mana
end

return character