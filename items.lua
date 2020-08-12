items = {}

function recursiveEnumerate(folder)
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		local fileInfo = lfs.getInfo(file)
		if fileInfo.type == "file" then
            local item = love.filesystem.load(file)()
            items[item.id] = item
		elseif fileInfo.type == "directory" then
			recursiveEnumerate(file)
		end
	end
end

recursiveEnumerate("items/")

return objects