local character = {
	
	position = {
		world_seed = nil,
		room = 1,
		x = 0,
		y = 0
	},

	-- current values
    health = 0,
	mana = 0,
	
	-- usages numbers
    passive_skills = {
		health = 0,
		mana = 0,
        sword = 0
    },
    active_skills = {
        thunder = 0
	},

	bag = { 1 }, -- index from items table
	equipped = {
		right_hand = 1 -- index from beg
	}
}

local function varToString(var)
	local result = "{"

	for title, value in pairs(var) do
		if type(value) == "function" or (type(title) == "string" and title:sub(1, 2) == "__") then
			goto continue
		end

		if type(title) == "string" then
			result = result..title.."="
		end
		
		if type(value) == "table" then
			result = result..varToString(value)
		elseif type(value) == "string" then
			result = result.."\""..value.."\""
		else
			result = result..tostring(value)
		end

		result = result..","

		::continue::
	end

	return result:sub(1, #result - 1).."}"
end

function character:getMaxHealth()
end

function character:getMaxMana()
end

function character:load()	
	if(love.filesystem.getInfo("save.lua") == nil) then
		return
	end

	local char = dofile(love.filesystem.getSaveDirectory().."/save.lua")
	setmetatable(char, self)
	self = char
end

function character:save()
    local file = love.filesystem.newFile("save.lua")
    file:open("w")
    file:write("local character = "..varToString(character).."\nreturn character")
    file:close()
end

return character