local dialogue = {
    index = 1,
    replicas = nil,
    started = false
}
function dialogue:start(replicas)
    self.replicas = replicas
    self.started = true
end
function dialogue:finish()
    self.index = 1
    self.started = false
end
function dialogue:nextReplica()
    self.index = self.index + 1
    if self.index > #self.replicas then
        self:finish()
    end
end

function dialogue:control_button(command)
    if command == Command.Confirm then
        self:nextReplica()
    elseif command == Command.Deny then
        self:finish()
    end
end
function dialogue:draw(camera)
    local h = love.graphics.getHeight()/9
    local x, y = love.graphics.inverseTransformPoint(0, love.graphics.getHeight()-h)

    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", x, 0, love.graphics.getWidth(), h)
    love.graphics.setColor(0, 0, 0)

    local y = love.graphics.getFont():getHeight()

    love.graphics.printf(self.replicas[self.index], x, y, (1/camera.scale)*love.graphics.getWidth(), "center")
    love.graphics.setColor(1, 1, 1)
end

return dialogue