local target = {
    positions = {
        {x=55, y=260},
        {x=185, y=180},
        {x=310, y=235}
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
    love.graphics.draw(self.image, self.positions[self.index].x, self.positions[self.index].y, 0, 0.5)
end

return target