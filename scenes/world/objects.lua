local objects = {
    filenames = {}
}

local files = love.filesystem.getDirectoryItems("scenes/world/objects")
for k, file in ipairs(files) do
    local filename = "scenes/world/objects/"..file
    local obj = love.filesystem.load("scenes/world/objects/"..file)()
    
    objects.filenames[obj.id] = filename
end

function objects:loadObject(id, x, y)
    local obj = love.filesystem.load(self.filenames[id])()
    obj.position.x = x
    obj.position.y = y
    return obj
end

return objects