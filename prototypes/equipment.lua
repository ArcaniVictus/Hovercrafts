if settings.startup["hovercraft-grid"].value == true then

local hgridw, hgridh = string.match(settings.startup["grid-hovercraft"].value, "(%d+)x(%d+)")
log("grid-hovercraft = "..tostring(settings.startup["grid-hovercraft"].value).." "..tostring(hgridw)..", "..tostring(hgridh))

local mgridw, mgridh = string.match(settings.startup["grid-missilecraft"].value, "(%d+)x(%d+)")
log("grid-missilecraft = "..tostring(settings.startup["grid-missilecraft"].value).." "..tostring(mgridw)..", "..tostring(mgridh))

-- Equipment
local hovercraft_equipment = {
	   type = "equipment-grid",
       name = "hovercraft-equipment",
       width = hgridw or 2,
       height = hgridh or 2,
       equipment_categories = { "armor" },
	}
local missilecraft_equipment = {
	   type = "equipment-grid",
       name = "missilecraft-equipment",
       width = mgridw or 4,
       height = mgridh or 2,
       equipment_categories = { "armor" },
	}

-- Support for Vortik's Armor Plating mod
	if mods["vtk-armor-plating"] then
	   table.insert(hovercraft_equipment.equipment_categories, "vtk-armor-plating")
	   table.insert(missilecraft_equipment.equipment_categories, "vtk-armor-plating")
	end
	
data:extend({
	hovercraft_equipment,
	missilecraft_equipment,
})
end