local chooseMagic = {}

local grid = love.filesystem.load("utils/grid.lua")()

local skills = {}
for skill, value in pairs(character.active_skills) do
    table.insert(skills, {
        id = skill,
        title = character:normalizeTitle(skill),
        comment = "LV: "..character:getSkillLevel(skill).." MP: "..character:getSkillLevel(skill)
    })
end

function chooseMagic:init(scene)
    grid:init("Magic menu", skills, scene)
end

grid.onConfirm = function(self)
    if character:getSkillLevel(self.list[self.current].id) <= character.mana then
        character.animation:setState("cast")
        self.additionObj.sceneState.current = self.additionObj.sceneState.target
        self.additionObj.target.spell = self.list[self.current].id
    end
end

grid.onDeny = function(self)
    self.additionObj.sceneState.current = self.additionObj.sceneState.action
end

function chooseMagic:control_button(command, scene)
    grid:control_button(command)
end

function chooseMagic:draw()
    grid:draw()
end

return chooseMagic