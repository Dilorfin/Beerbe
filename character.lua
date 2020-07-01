local character = {
    health = {
        current = 0,
		usageCount = 0
    },
    mana = {
        current = 0,
        usageCount = 0
    },
    military_skills = {
        sword = 0
    },
    magic_skills = {
        thunder = 0
    }
}

local function varToString(var)
	local result = "{"

	for title, value in pairs(var) do
		if type(value) == "function" or title:sub(1, 2) == "__" then
			goto continue
		end

		result = result..title
		result = result.."="

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