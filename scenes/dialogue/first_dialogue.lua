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
            title = love.graphics.newText(love.graphics.getFont(), "Disclaimer"),
            replica = "Текст...",
            animations = {
                {
                    id = 1,
                    x = 1,
                    y = 1
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "???"),
            replica = "TextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            animations = {
                {
                    id = 1,
                    x = 200,
                    y = 100
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Frame3"),
            replica = "frame2",
            animations = {
                {
                    id = 1,
                    x = 1,
                    y = 1
                }
            }
        }
    }
}

function scenario:onFinish()
    Scene.Load("world")
end

return scenario