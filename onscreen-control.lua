local onscreen = {
    buttons = {}
}
local assets = "asserts/onscreen-control/"
local newButton = love.filesystem.load("button.lua")()

local offset = 20
onscreen.buttons.up = newButton(assets.."up.png", offset + 87, love.graphics.getHeight()-(87*2+75), 75)
onscreen.buttons.down = newButton(assets.."down.png", offset + 87, love.graphics.getHeight() - 87, 75)
onscreen.buttons.left = newButton(assets.."left.png", offset, love.graphics.getHeight()-(87+75), 87)
onscreen.buttons.right = newButton(assets.."right.png", offset+87+75, love.graphics.getHeight()-(87+75), 87)

onscreen.buttons["return"] = newButton(assets.."A.png", love.graphics.getWidth()-125, love.graphics.getHeight()-250, 85)
onscreen.buttons.backspace = newButton(assets.."B.png", love.graphics.getWidth()-225, love.graphics.getHeight()-160, 85)


function onscreen:pressed(x, y)
    for key, button in pairs(self.buttons) do
        if button:isClicked(x, y) then
            love.keypressed(key)
        end
    end
end

function onscreen:released(x, y)
    Scene.control_axis("y", 0)
    Scene.control_axis("x", 0)
end

function onscreen:draw()
    for key, button in pairs(self.buttons) do
        button:draw()
    end
end

return onscreen