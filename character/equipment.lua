local equipment = {
    equiped = { -- items ids
        right_hand = 0,
        left_hand = 0
    }
}

function equipment:possible(place)
	local result = character.inventory:getEquippableIds()
	for p, itemId in pairs(self.equiped) do
		if p ~= place then
			table.removeByValue(result, itemId)
		end
	end
	table.insert(result, 1, 0)
	return result
end

function equipment:equip(place, itemId)
	self.equiped[place] = itemId or 0
end

function equipment:getPlaces()
	local places = {}
	for k, v in pairs(self.equiped) do
        table.insert(places, k)
	end
	return places
end

function equipment:getCurrent()
	return self.equiped
end

return equipment