require "utils/animation"
require "scenes/world/movable"

function newMovableTrainyEnemy(world, posX, posY)
	local position = {
		x = posX,
		y = posY
	}

	local enemyAnimation = newAnimation(
		love.graphics.newImage("assets/world/animations/whirlwind_green.png"), 48, 48, 0.11, 5, "loop"
	)
	enemyAnimation.setState = function() end
	
	local movable = newMovable(world, position, enemyAnimation)
	movable.onStartCollide = function (self, mvb)
		if mvb.tag == "hero" then
			self.isDestroyed = true
			events:push("start_fight")
		end
	end

	movable.ai = require("scenes/world/movables/trainy_enemy_ai")(movable)

	return movable
end
