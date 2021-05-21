local menu = {}

function menu:control_button(command, menuState)
    if command == Command.Deny then
        self.isClosed = true
    end
end

function menu:draw()
    love.graphics.print("In development...", 20, 20)
end

return menu