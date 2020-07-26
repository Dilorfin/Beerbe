local enemy_mt = {}
enemy_mt.__index = enemy_mt

local types = {
    {
        image = "asserts/fight/enemies/1.png",
        health = 15,
        damage = 10,
        defence = 10
    },
    {
        image = "asserts/fight/enemies/2.png",
        health = 15,
        damage = 10,
        defence = 10
    },
    {
        image = "asserts/fight/enemies/3.png",
        health = 15,
        damage = 10,
        defence = 10
    }
}

function enemy_mt:getHeight()
    return image:getHeight()
end
function enemy_mt:getWidth()
    return image:getWidth()
end

function enemy_mt:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale)
end

function newEnemy(type, slot)
    local slots = require "scenes/fight/slots"

    e = {}

    for key, value in pairs(types[type]) do
        e[key] = value
    end
    e.image = love.graphics.newImage(types[type].image)
    e.position = {
        x = slots[slot].x,
        y = slots[slot].y
    }
    e.scale = love.graphics.getHeight()/600
    return setmetatable(e, enemy_mt)
end