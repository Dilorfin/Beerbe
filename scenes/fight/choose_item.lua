local chooseItem = love.filesystem.load("utils/grid.lua")()

local ids = character.inventory:getUsableItemsIds()
local usables = {}
for i = 1, #ids do
	table.insert(usables, {
		id = ids[i],
		title = items[ids[i]].title,
		comment = ""
	})
end

chooseItem.title = "Items menu"
chooseItem.list = usables

function chooseItem:onConfirm()
	if #self.list <= 0 then
		return
	end
	
	events:push({
		type = "use_item",
		itemId = self.list[self.current].id
	})
end

function chooseItem:onDeny()
	events:push("user_action")
end

return chooseItem