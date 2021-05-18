local function removeByValue(arr, value)
    for i = 1, #arr do
        if arr[i] == value then
            table.remove(arr, i)
            return
        end
    end
end

table.removeByValue = removeByValue

local function clear(arr)
    for i = 1, #arr do
        arr[i] = nil
    end
end

table.clear = clear

local function indexOf(arr, value)
    local index={}
    for k,v in pairs(arr) do
        index[v]=k
    end
    return index[value]
end

table.indexOf = indexOf

--[[
    src - source table 
    s - start position of the range in src
    e - final position of the range in src
    pos - position to start inserting range to dst
    dst - destination table
]]
local function move(src, s, e, pos, dst)
    for i = s, e do
        dst[pos + i - 1] = src[i]
    end
end

table.move = move

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