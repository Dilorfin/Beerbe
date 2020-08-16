local enemy_mt = {}
enemy_mt.__index = enemy_mt

function enemy_mt:useSkill(skill)
    return self.damage
end

function enemy_mt:takeDamage(damage)
    if damage > 0 then
        self.health = self.health - damage
	end
end

function enemy_mt:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale)
end

local filenames = {}

local files = love.filesystem.getFilesRecursively("scenes/fight/enemies")
for i = 1, #files do
	local enemy = love.filesystem.load(files[i])()
    filenames[enemy.id] = files[i]
end

function newEnemy(type, slot)
    local slots = require "scenes/fight/slots"
    local enemy = love.filesystem.load(filenames[type])()

    enemy.slot = slot
    enemy.position = {
        x = slots[slot].x,
        y = slots[slot].y
    }
    enemy.scale = love.graphics.getHeight()/600
    return setmetatable(enemy, enemy_mt)
end