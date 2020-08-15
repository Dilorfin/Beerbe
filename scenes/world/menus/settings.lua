local menu = {}

function menu:load(font)
    self.font = font
end

function menu:unload()
end

function menu:update(delta_time)
end

function menu:control_button(command, menuState)
    if command == Command.Deny then
        menuState.current = menuState.chooseMenu
    end
end

function menu:draw()
    love.graphics.print("In development...", 0, 0)
end

return menu