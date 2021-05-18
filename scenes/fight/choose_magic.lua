local chooseMagic = {}
chooseMagic.index = 1
chooseMagic.skills = {}

local fontHeight = love.graphics.getFont():getHeight()

for skill, value in pairs(character.active_skills) do
    table.insert(chooseMagic.skills, skill)
end
table.sort(chooseMagic.skills)

function chooseMagic:control_button(command, scene)
    if command == Command.Confirm then
        if character:getSkillLevel(self.skills[self.index]) <= character.mana then
            character.animation:setState("cast")
            scene.sceneState.current = scene.sceneState.target
            scene.target.spell = self.skills[self.index]
        end
    elseif command == Command.Deny then
        scene.sceneState.current = scene.sceneState.action
    elseif command == Command.Up then
        if self.index > 3 then 
            self.index = self.index - 3
        end
    elseif command == Command.Down then
        if self.index < #self.skills - 2 then 
            self.index = self.index + 3
        end
    elseif command == Command.Left then
        if self.index > 1 then 
            self.index = self.index - 1
        end
    elseif command == Command.Right then
        if self.index < #self.skills then 
            self.index = self.index + 1
        end
    end
end

function chooseMagic:draw()
    love.graphics.printf("Magic menu", 0, 20, love.graphics.getWidth(), "center")

    local cellWidth = love.graphics.getWidth()/3
    local cellHeight = 100
    
    for i, skill in pairs(self.skills) do
        local posX = cellWidth*((i-1)%3)
        local posY = cellHeight*math.ceil(i/3)
        love.graphics.printf(character:normalizeTitle(skill), posX, posY, cellWidth, "center")
        love.graphics.printf("LV: "..character:getSkillLevel(skill).." MP: "..character:getSkillLevel(skill), posX, posY + fontHeight, cellWidth, "center")
    end
    
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", 10 + cellWidth * ((self.index-1) % 3 ), cellHeight*(math.ceil(self.index/3))-20, cellWidth - 20, 90, 10, 10)
    love.graphics.setLineWidth(1)
end

return chooseMagic