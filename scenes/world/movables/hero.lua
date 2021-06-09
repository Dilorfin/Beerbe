require "utils/multistate_animation"
require "scenes/world/movable"

function newMovableHero(world, position)
	local heroFilenames = {
		"assets/world/animations/upward.png",
		"assets/world/animations/downward.png",
		"assets/world/animations/leftward.png",
		"assets/world/animations/rightward.png"
	}
	local heroAnimation = newMultistateAnimation(
		heroFilenames, 48, 48, 0.11, 3, "bounce"
	)
	heroAnimation:setState(2)
	return newMovable(world, position, heroAnimation, "hero")
end
