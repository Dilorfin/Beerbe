local enemy_mt = {}
enemy_mt.__index = enemy_mt

local slots = {
    { x=65, y=250 },
    { x=195, y=170 },
    { x=320, y=225 }
}
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
    love.graphics.draw(self.image, self.position.x, self.position.y)
end

function newEnemy(type, slot)
    e = {}

    for key, value in pairs(types[type]) do
        e[key] = value
    end

    e.image = love.graphics.newImage(types[type].image)
    e.position = {
        x = slots[slot].x,
        y = slots[slot].y
    }
    return setmetatable(e, enemy_mt)
end