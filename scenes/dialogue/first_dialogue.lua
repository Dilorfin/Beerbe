local scenario = {
    resources = {
        backgrounds = {
            [1] = love.graphics.newImage("asserts/dialogue/first/frame0.png"),
            [2] = love.graphics.newImage("asserts/dialogue/first/frame1.png"),
            [3] = love.graphics.newImage("asserts/dialogue/first/frame2.png"),
            [4] = love.graphics.newImage("asserts/dialogue/first/frame3.png"),
            [5] = love.graphics.newImage("asserts/dialogue/first/frame4.png")
        },
        animations = {
            [1] = newAnimation(love.graphics.newImage("asserts/dialogue/first/stand_left.png"), 64, 64, 0.175, 3),
            [2] = newAnimation(love.graphics.newImage("asserts/dialogue/first/stand_right.png"), 64, 64, 0.175, 3),
            [3] = newAnimation(love.graphics.newImage("asserts/dialogue/first/Thunder3.png"), 74, 74, 0.15, 4),
            [4] = newAnimation(love.graphics.newImage("asserts/dialogue/first/Thunder2.png"), 154, 154, 0.15, 4),
            [5] = newAnimation(love.graphics.newImage("asserts/dialogue/first/zeus.png"), 282, 285, 0, 1)
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
            title = love.graphics.newText(love.graphics.getFont(), "..."),
            replica = "*бабах*",
            animations = {
                {
                    id = 1,
                    x = 500,
                    y = 400
                },
                {
                    id = 3,
                    x = 495,
                    y = 395
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "..."),
            replica = "*бабах*",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 245,
                    y = 270
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "... ээм? Что? Где я?",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "..."),
            replica = "*опять бабах*",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 4,
                    x = 495,
                    y = 205
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Ну привет гандон ушастый...",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "..э!?",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Шо вылупился?",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Значит сначала пользуется добрым именем, а потом удивляется шо с ним пришли беседы беседовать!!!",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "Чеэгооо?! О.О",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Того!.. Кароче, я обиделся...",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "...теперь крутись как хочешь!",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "..."),
            replica = "*и снова бабах*",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                },
                {
                    id = 5,
                    x = 500,
                    y = 210
                },
                {
                    id = 4,
                    x = 495,
                    y = 205
                }
            }
        },
        {
            background = 5,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "Ох блин...",
            animations = {
                {
                    id = 2,
                    x = 250,
                    y = 275
                }
            }
        }
    }
}

function scenario:onFinish()
    Scene.Load("world")
end

return scenario