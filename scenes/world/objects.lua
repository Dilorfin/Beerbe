local objects = {
    filenames = {}
}

function recursiveEnumerate(folder)
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		local fileInfo = lfs.getInfo(file)
		if fileInfo.type == "file" then
            local obj = love.filesystem.load(file)()
            objects.filenames[obj.id] = file
		elseif fileInfo.type == "directory" then
			recursiveEnumerate(file)
		end
	end
end

recursiveEnumerate("scenes/world/objects")

function objects:loadObject(id, x, y)
    local obj = love.filesystem.load(self.filenames[id])()
    obj.position.x = x
    obj.position.y = y
    return obj
end

return objects