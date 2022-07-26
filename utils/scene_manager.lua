local scenesFolder = "scenes"

local currentScene = nil
local previousScene = nil

Scene = {}

local mt = setmetatable(Scene, {
	__index = function(t,k)
			if currentScene and type(currentScene[k]) == "function" then
				return currentScene[k]
			end
			return function() end
		end
})

function Scene.Load(name)
	local startTime = love.timer.getTime()

	if currentScene then Scene.unload() end
	if previousScene then previousScene.unload() end

	local chunk = love.filesystem.load(scenesFolder.."/"..name..".lua")
	if not chunk then 
		error("Attempt to load scene \"" .. name .. "\", but it was not found in \""..scenesFolder.."\" folder.", 2)
	end
	currentScene = chunk()
	previousScene = nil

	collectgarbage()
	Scene.load()

	local endTime = love.timer.getTime()
	print(name.." Load time: "..(endTime - startTime))
end

function Scene.LoadNext(name)
	local startTime = love.timer.getTime()

	if previousScene then error("several scenes in stack is not supported") end

	if currentScene then
		if Scene.pause then Scene.pause() end
		previousScene = currentScene
	end

	local chunk = love.filesystem.load(scenesFolder.."/"..name..".lua")
	if not chunk then error("Attempt to load scene \"" .. name .. "\", but it was not found in \""..scenesFolder.."\" folder.", 2) end
	currentScene = chunk()
	collectgarbage()
	Scene.load()

	local endTime = love.timer.getTime()
	print(name.." LoadNext time: "..(endTime - startTime))
end

function Scene.GoBack()
	local startTime = love.timer.getTime()

	if not previousScene then return end

	Scene.unload()
	currentScene = previousScene
	previousScene = nil
	collectgarbage()

	local endTime = love.timer.getTime()
	print("GoBack time: "..(endTime - startTime))
end
