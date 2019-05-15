-- add equipment grid to hovercraft and missilecraft if startup setting selected
if settings.startup["hovercraft-grid"].value == true then
	local crafts = {
		["hovercraft-entity"] = "hovercraft-equipment",
		["missilecraft"] = "missilecraft-equipment",
	}
	for vehiculename, vehiculegrid in pairs(crafts) do
		local entity = data.raw["car"][vehiculename]
		if entity then
			entity.equipment_grid = vehiculegrid
		end
	end
end