local info = {
    isActive = false,
    text = nil,
    onConfirm = nil
}

function info:show(text, onConfirm)
    self.text = text
    self.onConfirm = onConfirm
    
    self.isActive = true
end

function info:close()
    self.text = nil
    self.onConfirm = nil

    self.isActive = false
end

function info:control_button(command)
    if not self.isActive then return end

    if command == Command.Confirm and self.onConfirm then
        self.onConfirm()
    end
end

function info:draw(camera)
    if not self.isActive then return end

    local screenHeight = love.graphics.getHeight()
    local screenWidth = love.graphics.getWidth()
    local h = screenHeight / 9
    local x, y = love.graphics.inverseTransformPoint(0, screenHeight - h)

    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", x, y, screenWidth, h)
    love.graphics.setColor(0, 0, 0)

    y = y + love.graphics.getFont():getHeight()/1.5
    
    love.graphics.printf(self.text, x, y, (1/camera.scale) * screenWidth, "center")
    love.graphics.setColor(1, 1, 1)
end

return info