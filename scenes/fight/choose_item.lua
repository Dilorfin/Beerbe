local chooseItem = {}
local grid = love.filesystem.load("utils/grid.lua")()

local ids = character.inventory:getUsableItemsIds()
local usables = {}
for i = 1, #ids do
    table.insert(usables, {
        id = ids[i],
        title = items[ids[i]].title,
        comment = "test"
    })
end

grid.onConfirm = function(self)
    if #self.list <= 0 then
        return
    end
    
    local item = items[self.list[self.current].id]
    item:use(character)
    character.inventory:removeItem(item.id)
    table.remove(self.list, self.current)
    self.additionObj.current = self.additionObj.action
end

grid.onDeny = function(self)
    self.additionObj.current = self.additionObj.action
end

function chooseItem:init(sceneState)
    grid:init("Items menu", usables, sceneState)
end

function chooseItem:control_button(command)
    grid:control_button(command)
end

function chooseItem:draw()
    grid:draw()
end

return chooseItem