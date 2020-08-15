items = {}

local files = love.filesystem.getFilesRecursively("items")
for i = 1, #files do
	local item = love.filesystem.load(files[i])()
    items[item.id] = item
end

return items