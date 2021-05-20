local enemy_mt = {}
enemy_mt.__index = enemy_mt

function enemy_mt:turn(actors)
    events:push({
        type = "attack",
        damage = self:useSkill(),
        target = actors:getCharacterId(),
        skill = "hit"
    })
end

function enemy_mt:useSkill(skill)
    return self.damage
end

function enemy_mt:takeDamage(damage)
    if damage > 0 then
        self.health = self.health - damage
	end
end

function enemy_mt:draw(x, y)
    love.graphics.draw(self.image, x, y, 0, self.scale)
end

local filenames = {}

local files = love.filesystem.getFilesRecursively("scenes/fight/enemies")
for i = 1, #files do
	local enemy = love.filesystem.load(files[i])()
    filenames[enemy.id] = files[i]
end

function newEnemy(type, id)
    local enemy = love.filesystem.load(filenames[type])()

    enemy.scale = love.graphics.getHeight()/600
    return setmetatable(enemy, enemy_mt)
end