local inventory = {
	items = { 1, 2 }
}

function inventory:addItem(id)
	table.insert(self.items, id)
end

function inventory:addItemsList(list)
	table.move(list, 1, #list, #self.items + 1, self.items)
end

function inventory:removeItem(id)
	table.removeByValue(self.items, id)
end

function inventory:getEquippable()
	local result = {}
	for index, id in ipairs(self.items) do
		if items[id].type == "sword" then
			table.insert(result, id)
		end
	end
	return result
end

function inventory:getUsableItems()
	local result = {}
	for index, id in ipairs(self.items) do
		if items[id].use then
			table.insert(result, id)
		end
	end
	return result
end

local character = {
	name = "Hero",
	position = {
		room = 0
	},

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

	inventory = inventory,
	equipment = { -- items ids
		right_hand = 0,
		left_hand = 0
	}
}

function character.equipment:possible(place)
	local result = character.inventory:getEquippable()
	for p, itemId in pairs(self:getCurrent()) do
		if p ~= place then
			table.removeByValue(result, itemId)
		end
	end
	table.insert(result, 1, 0)
	return result
end

function character.equipment:equip(place, itemId)
	character.equipment[place] = itemId or 0
end

function character.equipment:getPlaces()
	local places = {}
	for k, v in pairs(self) do
		if type(v) == "number" then
			table.insert(places, k)
		end
	end
	return places
end

function character.equipment:getCurrent()
	local current = {}
	for k, v in pairs(self) do
		if type(v) == "number" then
			current[k] = v
		end
	end
	return current
end

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
		if self.equipment.right_hand > 0 then
			damage = items[self.equipment.right_hand].damage
		end
		if self.equipment.left_hand > 0 then
			damage = damage + items[self.equipment.left_hand].damage
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