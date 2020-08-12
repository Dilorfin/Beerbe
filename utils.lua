local function removeByValue(arr, value)
    for i = 1, #arr do
        if arr[i] == value then
            table.remove(arr, i)
            return
        end
    end
end

table.removeByValue = removeByValue

local function getFilesRecursively(folder, files)
    files = files or {}
	local filesTable = love.filesystem.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		local fileInfo = love.filesystem.getInfo(file)
        if fileInfo.type == "file" then
            table.insert(files, file)
		elseif fileInfo.type == "directory" then
			getFilesRecursively(file, files)
		end
    end
    return files
end

love.filesystem.getFilesRecursively = getFilesRecursively