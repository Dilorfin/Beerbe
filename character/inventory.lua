local inventory = {
	items = { 1, 2 }
}

function inventory:addItem(id)
	table.insert(self.items, id)
end

function inventory:addItemsList(list)
	table.move(list, 1, #list, #self.items + 1, self.items)
end

function inventory:removeItem(id)
	table.removeByValue(self.items, id)
end

function inventory:getEquippableIds()
	local result = {}
	for index, id in ipairs(self.items) do
		if items[id].type == "sword" then
			table.insert(result, id)
		end
	end
	return result
end

function inventory:getUsableItemsIds()
	local result = {}
	for index, id in ipairs(self.items) do
		if items[id].use then
			table.insert(result, id)
		end
	end
	return result
end

return inventory