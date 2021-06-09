local character = {
	name = "Hero",
	levelId = 0,

	-- current values
    health = 15,
	mana = 5,
	
	-- usages numbers
    passive_skills = {
		health = 1,
		mana = 1
	},
    active_skills = {
		thunder = 1
	},

	inventory = love.filesystem.load("character/inventory.lua")(),
	equipment = love.filesystem.load("character/equipment.lua")()
}

function character:getMaxHealth()
	return 15 * self:getSkillLevel("health")
end

function character:getMaxMana()
	return 5 * self:getSkillLevel("mana")
end

function character:normalizeTitle(name)
	-- format for displaying "right_hand" -> "Right hand"
	return name:gsub("_", " "):gsub("^%l", string.upper)
end

function character:getSkillUsages(skill)
	if self.passive_skills[skill] ~= nil then
		return self.passive_skills[skill]
	end
	if self.active_skills[skill] ~= nil then
		return self.active_skills[skill]
	end
	return 0
end

function character:getSkillLevel(skill)
	return math.ceil(self:getSkillUsages(skill)/10)
end

function character:hasEnoughMana(skill)
	return self:getSkillLevel(skill) <= self.mana
end

function character:increasePassiveSkill(skill)
	if self.passive_skills[skill] == nil then
		self.passive_skills[skill] = 0
	end
	self.passive_skills[skill] = self.passive_skills[skill] + 1
end

function character:increaseActiveSkill(skill)
	if self.active_skills[skill] == nil then
		self.active_skills[skill] = 0
	end
	self.active_skills[skill] = self.active_skills[skill] + 1
end

function character:getDamage(skill)
	local damage = 0
	
	if skill == "sword" then
		local equipment = self.equipment:getCurrent()
		if equipment.right_hand > 0 then
			damage = items[equipment.right_hand].damage
		end
		if equipment.left_hand > 0 then
			damage = damage + items[equipment.left_hand].damage
		end

		damage = damage * self:getSkillLevel("sword")		
		
	else
		damage = self:getSkillLevel("mana") * self:getSkillLevel(skill)
	end
	
	return damage
end

function character:useSkill(skill)
	local damage = self:getDamage(skill)
	if skill == "sword" then
		self:increasePassiveSkill("sword")
	else
		self.mana = self.mana - self:getSkillLevel(skill)
		self:increaseActiveSkill(skill)
		self:increasePassiveSkill("mana")
	end

	return damage
end

function character:takeDamage(damage)
	if damage > 0 then
		self.health = self.health - damage
		self:increasePassiveSkill("health")
	end
end

function character:turn()
	events:push({
        type = "user_action"
    })
end

return character