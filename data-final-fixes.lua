-- data-final-fixes.lua

-- Player
for index, character in pairs(data.raw.character) do
     character.collision_mask = {"player-layer", "train-layer", "consider-tile-transitions", "layer-12"}
end

-- Remove collision mask from water tiles
for k,waterTiles in pairs({"water","water-green","deepwater","deepwater-green"}) do
	if data.raw.tile[waterTiles] then
		local mask = data.raw.tile[waterTiles].collision_mask
		for i=#mask,1,-1 do
			if mask[i] == "player-layer" then	  -- only change if not already altered by another mod
				mask[i] = "layer-12"
			end
		end
	end
end


-- Add collision mask to vehicles
local vehicles = data.raw.car
for k,v in pairs(vehicles) do
	-- string.find allows other mods to add other named versions (ie aai-...)
	if string.find(k,"hcraft-entity",1,true)==nil and string.find(k,"ecraft-entity",1,true)==nil and string.find(k,"mcraft-entity",1,true)==nil and string.find(k,"lcraft-entity",1,true)==nil then
		local mask = data.raw.car[k].collision_mask
		if mask == nil then			-- if not defined, set new default
			data.raw.car[k].collision_mask = {"player-layer","train-layer","layer-12"}
		elseif #mask > 0 then	  	-- ignore vehicles with no collision_mask (ie airplanes)
			data.raw.car[k].collision_mask[#mask+1] = "layer-12"
		end
	end
end

-- Add collision mask to units
local units = data.raw.unit
for k,v in pairs(units) do
	-- skip aai generated hovercraft units
	if string.find(k,"hcraft-entity",1,true)==nil and string.find(k,"ecraft-entity",1,true)==nil and string.find(k,"mcraft-entity",1,true)==nil and string.find(k,"lcraft-entity",1,true)==nil then
		local mask = data.raw.unit[k].collision_mask
		if mask == nil then			-- if not defined, set new default
			data.raw.unit[k].collision_mask = {"player-layer","train-layer","layer-12"}
		elseif #mask > 0 then	  	-- ignore units with explicitly no collision_mask
			data.raw.unit[k].collision_mask[#mask+1] = "layer-12"
		end
	end
end