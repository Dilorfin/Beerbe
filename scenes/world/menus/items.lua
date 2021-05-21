local itemsMenu = love.filesystem.load("utils/grid.lua")()

local usableItems = character.inventory:getUsableItemsIds()

itemsMenu.title = "Items menu"
itemsMenu.list = {}
for i = 1, #usableItems do
	table.insert(itemsMenu.list, {
		id = usableItems[i],
		title = items[usableItems[i]].title,
		comment = ""
	})
end

function itemsMenu:onConfirm()
	if #self.list <= 0 then
		return
	end

	local item = items[self.list[self.current].id]
	item:use(character)
	table.remove(self.list, self.current)
	character.inventory:removeItem(item.id)

	if self.current > #self.list then
		self.current = #self.list
	end
end

function itemsMenu:onDeny()
	self.isClosed = true
end

return itemsMenu