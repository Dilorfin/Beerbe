local scenario = {
    resources = {
        backgrounds = {
            [1] = love.graphics.newImage("asserts/dialogue/last/background.png"),
            [2] = love.graphics.newImage("asserts/dialogue/last/background2.png")
        },
        animations = {
            [1] = newAnimation(love.graphics.newImage("asserts/dialogue/first/stand_right.png"), 64, 64, 0.175, 3),
            [2] = newAnimation(love.graphics.newImage("asserts/dialogue/first/Thunder3.png"), 74, 74, 0.15, 4),
            [3] = newAnimation(love.graphics.newImage("asserts/dialogue/first/zeus.png"), 282, 285, 0, 1)
        }
    },
    frames = {
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "Хух, Gotcha!",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Миша"),
            replica = "Ну что, достоин ли я называться богом молнии в мире, где не верят в богов?",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "О, ты жив...",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Забавно получилось! :)",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Зевс"),
            replica = "Ну ладно, вали к себе, если чё потом пообщаемся, я сейчас немного занят...",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "XXX"),
            replica = "Зевушка, ты там долго ещё? Я тебя уже заждалась...",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "..."),
            replica = "*финальный бабах*",
            animations = {
                {
                    id = 1,
                    x = 250,
                    y = 275
                },
                {
                    id = 2,
                    x = 245,
                    y = 270
                },
                {
                    id = 3,
                    x = 500,
                    y = 210
                }
            }
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Вот така херня, малята...",
            animations = {}
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Ох, простите...",
            animations = {}
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Вот и закончилось эпичное приключение Миши!",
            animations = {}
        },
        {
            background = 1,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Миша, я и моя молодая команда...",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Поздравляем тебя с Днем Рождения!",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Желаем счастья, здоровья",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "и ебаться не только с лабками в универе :)",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Ну, и вообще, у тебя всё ещё впереди!",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "Ты все сможешь!",
            animations = {}
        },
        {
            background = 2,
            title = love.graphics.newText(love.graphics.getFont(), "Голос За Кадром"),
            replica = "To be continued....",
            animations = {}
        }
    }
}

function scenario:onFinish()
    love.event.quit()
end

return scenario