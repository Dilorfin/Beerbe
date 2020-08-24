local scenario = {
    resources = {
        backgrounds = {
            [1] = love.graphics.newImage("asserts/fight/background.png")
        },
        animations = {
            [1] = newAnimation(love.graphics.newImage("asserts/world/objects/dev_room/portal.png"), 48, 48, 0.15, 12)
        }
    },
    frames = {
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Title"),
            replica = "Текст",
            animations = {
                {
                    id = 1,
                    x = 1,
                    y = 1
                }
            }
        },
    }
}

function scenario:onFinish()
    love.event.quit()
end

return scenario