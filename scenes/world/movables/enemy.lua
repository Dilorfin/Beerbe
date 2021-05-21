require "utils/animation"
require "scenes/world/movable"

function newMovableEnemy(world, posX, posY)
    local character = {
        position = {
            x = posX,
            y = posY
        }
    }

    local enemyAnimation = newAnimation(
        love.graphics.newImage("assets/world/animations/whirlwind.png"), 48, 48, 0.11, 5, "loop"
    )
    enemyAnimation.setState = function() end
    
    local movable = newMovable(world, character, enemyAnimation)
    movable.onStartCollide = function (self, mvb)
        if mvb.character and mvb.character.name == "Hero" then
            self.isDestroyed = true
            events:push({
                type = "start_fight"
            })
        end
    end

    return movable
end
