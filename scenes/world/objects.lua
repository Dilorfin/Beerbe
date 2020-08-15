local objects = {
    filenames = {}
}

local files = love.filesystem.getFilesRecursively("scenes/world/objects")
for i = 1, #files do
	local obj = love.filesystem.load(files[i])()
    objects.filenames[obj.id] = files[i]
end

function objects:loadObject(id, x, y)
    local obj = love.filesystem.load(self.filenames[id])()
    obj.position.x = x
    obj.position.y = y
    return obj
end

return objects