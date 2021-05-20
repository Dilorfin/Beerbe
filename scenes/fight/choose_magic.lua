local chooseMagic = love.filesystem.load("utils/grid.lua")()

local skills = {}
for skill, value in pairs(character.active_skills) do
	table.insert(skills, {
		id = skill,
		title = character:normalizeTitle(skill),
		comment = "LV: "..character:getSkillLevel(skill).." MP: "..character:getSkillLevel(skill)
	})
end

chooseMagic.title = "Magic menu"
chooseMagic.list = skills

function chooseMagic:onConfirm()
	if character:hasEnoughMana(self.list[self.current].id) then
		events:push({
			type = "target",
			skill = self.list[self.current].id
		})
		character.animation:setState("cast")
	end
end

function chooseMagic:onDeny()
	events:push("user_action")
end

return chooseMagic