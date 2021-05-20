local chooseMagic = love.filesystem.load("utils/grid.lua")()

function chooseMagic:init(scene)
	local skills = {}
	for skill, value in pairs(character.active_skills) do
		table.insert(skills, {
			id = skill,
			title = character:normalizeTitle(skill),
			comment = "LV: "..character:getSkillLevel(skill).." MP: "..character:getSkillLevel(skill)
		})
	end

	self.title = "Magic menu"
	self.list = skills
	self.additionObj = scene
end

function chooseMagic:onConfirm()
	if character:getSkillLevel(self.list[self.current].id) <= character.mana then
		character.animation:setState("cast")
		self.additionObj.sceneState.current = self.additionObj.sceneState.target
		self.additionObj.target.spell = self.list[self.current].id
	end
end

function chooseMagic:onDeny()
	events:push("user_action")
end

return chooseMagic