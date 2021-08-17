local obj = {
    id = 11,
    animation = newAnimation(love.graphics.newImage("assets/world/objects/chest.png"), 48, 96, 0.1, 3),
    position = {},
    width = 1,
    height = 1,
    isOpened = false,
    
    physics = {
        size = {
            x = 48,
            y = 48
        },
        offset = {
            x = 24,
            y = 24
        }
    }
}

function obj:init(initData)
    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    
    self.animation:stop()
    self.animation:setMode("once")

    self.infoText = "Open chest?"
end

function obj:onStartCollide(movable)
    if self.isOpened 
        or not movable.character 
        or movable.character.name ~= "Hero" 
    then
        return nil
    end

    return { 
        type = "show_info",
        text = self.infoText,
        onConfirm = function()
            obj.animation:play()
            obj.isOpened = true
            events:push({
                type = "close_info",
                text = self.infoText
            })
            events:push({
                type = "give_items",
                items = obj.generateContent()
            })
        end
    }
end

function obj:onEndCollide(movable)
    return {
        type = "close_info",
        text = self.infoText
    }
end

function obj.generateContent()
    local itemsToGive = {}

    -- some healing
    local prob = love.math.random(0, 100)
    if prob <= 75 then -- 0.33l
        local num = love.math.random(1, 3)
        for i = 1, num do
            itemsToGive[#itemsToGive+1] = 2
        end
    elseif prob <= 95 then -- 0.5l
        local num = love.math.random(1, 2)
        for i = 1, num do
            itemsToGive[#itemsToGive+1] = 4
        end
    else -- 1l
        itemsToGive[#itemsToGive+1] = 3
    end

    local prob = love.math.random(0, 100)

    -- weapon
    if prob <= 15 then 
        local prob = love.math.random(0, 100)
        if prob >= 90 then
            itemsToGive[#itemsToGive+1] = 6
        else
            itemsToGive[#itemsToGive+1] = 1
        end
    end
    return itemsToGive
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    self.animation:draw(self.position.x, self.position.y)
end

return obj