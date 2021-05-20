local chooseItem = love.filesystem.load("utils/grid.lua")()

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

function chooseItem:init()
	local ids = character.inventory:getUsableItemsIds()
	local usables = {}
	for i = 1, #ids do
		table.insert(usables, {
			id = ids[i],
			title = items[ids[i]].title,
			comment = ""
		})
	end

	self.title = "Items menu"
	self.list = usables
end

return chooseItem