local chooseItem = love.filesystem.load("utils/grid.lua")()

function chooseItem:open(place)
	local filteredItems = character.equipment:possible(place)
	chooseItem.list = {}

	table.insert(chooseItem.list, {
		id = 0,
		title = "nothing",
		comment = "exetly nothing"
	})
	for i = 2, #filteredItems do
		table.insert(chooseItem.list, {
			id = filteredItems[i],
			title = items[filteredItems[i]].title,
			comment = ""
		})
	end

	self.title = "Items menu"
	self.active = true
	self.place = place
	if not place then
		error("equipment cant be set to nothing")
	end
end

function chooseItem:onConfirm()
	local itemId = self.list[self.current].id
	character.equipment:equip(self.place, itemId)
	
	self.active = false
	self.current = 1
end

function chooseItem:onDeny()
	self.active = false
	self.current = 1
end

return chooseItem