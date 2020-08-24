local scenario = {
    resources = {
        backgrounds = {
            [1] = love.graphics.newImage("asserts/dialogue/first/frame0.png"),
            [2] = love.graphics.newImage("asserts/dialogue/first/frame1.png"),
            [3] = love.graphics.newImage("asserts/dialogue/first/frame2.png"),
            [4] = love.graphics.newImage("asserts/dialogue/first/frame3.png"),
        },
        animations = {
            [1] = newAnimation(love.graphics.newImage("asserts/fight/animations/stand.png"), 64, 64, 0.175, 3),
            [2] = newAnimation(love.graphics.newImage("asserts/dialogue/first/Thunder3.png"), 74, 74, 0.15, 4)
        }
    },
    frames = {
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Disclaimer"),
            replica = "All characters appearing in this work are fictitious.\nAny resemblance to real persons, living or dead, is purely coincidental.",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Жил был на свете забавный чувачёк, звали его Мишей",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                }
            }
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Жил не тужил, на звезды засматривался",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                }
            }
        },
        {
            background = 3,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "в шараге учился",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                }
            }
        },
        {
            background = 4,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "да в компьютерные игры играл.",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                }
            }
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "и вот однажды...",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                }
            }
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "...",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                },
                {
                    id = 2,
                    x = 495,
                    y = 395
                }
            }
        },
    }
}

function scenario:onFinish()
    Scene.Load("world")
end

return scenario