-- prototypes.equipment.lua

-- Checks settings and handles equipment grid for hovercraft and mcraft-entity
if settings.startup["hovercraft-grid"].value == true then

  local hgridw, hgridh = string.match(settings.startup["grid-hcraft"].value, "(%d+)x(%d+)")
  log("grid-hovercraft = " .. tostring(settings.startup["grid-hcraft"].value) .. " " .. tostring(hgridw) .. ", " .. tostring(hgridh))

  local mgridw, mgridh = string.match(settings.startup["grid-mcraft"].value, "(%d+)x(%d+)")
  log("grid-mcraft-entity = " .. tostring(settings.startup["grid-mcraft"].value) .. " " .. tostring(mgridw) .. ", " .. tostring(mgridh))

  -- Equipment
  local hcraft_equipment = {
    type = "equipment-grid",
    name = "hcraft-equipment",
    width = hgridw or 2,
    height = hgridh or 2,
    equipment_categories = {"armor"}
  }
  local mcraft_equipment = {
    type = "equipment-grid",
    name = "mcraft-equipment",
    width = mgridw or 4,
    height = mgridh or 2,
    equipment_categories = {"armor"}
  }

  -- Support for Bob Vehicle Equipment mod
  if mods["bobvehicleequipment"] then
    hcraft_equipment.equipment_categories = {"car", "vehicle"}
    mcraft_equipment.equipment_categories = {"tank", "vehicle", "armoured-vehicle"}
  end

  -- Support for Vortik's Armor Plating mod
  if mods["vtk-armor-plating"] then
    table.insert(hcraft_equipment.equipment_categories, "vtk-armor-plating")
    table.insert(mcraft_equipment.equipment_categories, "vtk-armor-plating")
  end

  data:extend({
    hcraft_equipment,
    mcraft_equipment,
  })
end
