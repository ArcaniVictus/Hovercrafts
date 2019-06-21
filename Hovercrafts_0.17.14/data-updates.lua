-- data-updates.lua

-- add equipment grid to hovercraft and mcraft-entity if startup setting selected
if settings.startup["hovercraft-grid"].value == true then
	local crafts = {
		["hcraft-entity"] = "hcraft-equipment",
		["mcraft-entity"] = "mcraft-equipment",
	}
	for vehiculename, vehiculegrid in pairs(crafts) do
		local entity = data.raw.car[vehiculename]
		if entity then
			entity.equipment_grid = vehiculegrid
		end
	end
end