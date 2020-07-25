local target = {
    positions = {
        {
            x=0.06875 * love.graphics.getWidth(),
            y=0.43333333333333335 * love.graphics.getHeight()
        },
        {
            x=0.23125 * love.graphics.getWidth(),
            y=0.3 * love.graphics.getHeight()
        }, 
        {
            x=0.3875 * love.graphics.getWidth(),
            y=0.39166666666666666 * love.graphics.getHeight()
        } 
    },
    index = 1,
    rotate = 0,
    type = ""
}

target.image = love.graphics.newImage("asserts/fight/select.png")

function target:left()
    self.index = self.index - 1
    if self.index <= 0 then
        self.index = #self.positions
    end
end
function target:right()
    self.index = self.index + 1
    if self.index > #enemies then
        self.index = 1
    end
end

function target:draw()
    love.graphics.draw(self.image, self.positions[self.index].x, self.positions[self.index].y, 0, love.graphics.getHeight()/1200)
end

return target