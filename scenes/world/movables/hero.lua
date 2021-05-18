require "utils/multistate_animation"
require "scenes/world/movable"

function newMovableHero(world)
    local heroFilenames = {
        "asserts/world/animations/upward.png",
        "asserts/world/animations/downward.png",
        "asserts/world/animations/leftward.png",
        "asserts/world/animations/rightward.png"
    }
    local heroAnimation = newMultistateAnimation(
        heroFilenames, 48, 48, 0.11, 3, "bounce"
    )
    heroAnimation:setState(2)
    
    return newMovable(world, character, heroAnimation)
end
