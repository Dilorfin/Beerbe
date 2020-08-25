local objects = {
    filenames = {}
}

local files = love.filesystem.getFilesRecursively("scenes/world/objects")
for i = 1, #files do
	local obj = love.filesystem.load(files[i])()
    objects.filenames[obj.id] = files[i]
end

function objects:loadObject(id, x, y, initData)
    local obj = love.filesystem.load(self.filenames[id])()
    obj.position.x = x
    obj.position.y = y
    if obj.init then
        obj:init(initData)
    end
    return obj
end

return objects