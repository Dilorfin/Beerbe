local button_mt = {}
button_mt.__index = button_mt

function button_mt:isClicked(x, y)
    return x > self.position.x and x < self.position.x + self.width
        and y > self.position.y and y < self.position.y + self.height
end

function button_mt:resize(w, h)
    local im_width, im_height = self.image:getDimensions()
    self.scale.x = w / im_width
    self.width = self.scale.x * im_width
    if not h then
        self.scale.y = self.scale.x
    else
        self.scale.y = h / im_height
    end
    self.height = self.scale.y * im_height
end

function button_mt:draw()
    local globalX, globalY = love.graphics.inverseTransformPoint(self.position.x, self.position.y)
    love.graphics.draw(self.image, globalX, globalY, 0, self.scale.x, self.scale.y)
end

return function (imageFile, x, y, w, h)
    local button = setmetatable({}, button_mt)
    button.image = love.graphics.newImage(imageFile)
    button.position = {
        x = x,
        y = y
    }
    button.scale = {
        x = 1,
        y = 1
    }
    button.width = 0
    button.height = 0

    button:resize(w, h)
    return button
end