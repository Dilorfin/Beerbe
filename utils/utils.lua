utils = {}

function utils.distance(x1, y1, x2, y2)
	return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end

function utils.unitVector(x1, y1, x2, y2)
	local v = { 
		x = x1 - x2,
		y = y1 - y2,
	}
	local m = math.sqrt(v.x^2+v.y^2)
	v.x = v.x / m
	v.y = v.y / m

	return v
end

function utils.hasObstacles(world, x1, y1, x2, y2)
	local obs = nil
	world:rayCast(x1, y1, x2, y2,
		function(fixture, x, y, xn, yn, fraction)
			local ud = fixture:getUserData()
			if fixture:isSensor() or (ud and ud.character) then
				return 1
			end
			obs = fixture
			return 0
		end
	)
	return obs
end
