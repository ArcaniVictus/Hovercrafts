-- prototypes.equipment.lua

-- Checks settings and handles equipment grid for hovercraft and mcraft-entity
if settings.startup["hovercraft-grid"].value == true then

  local hgridw, hgridh = string.match(settings.startup["grid-hcraft"].value, "(%d+)x(%d+)")
  log("grid-hovercraft = " .. tostring(settings.startup["grid-hcraft"].value) .. " " .. tostring(hgridw) .. ", " .. tostring(hgridh))

  local mgridw, mgridh = string.match(settings.startup["grid-mcraft"].value, "(%d+)x(%d+)")
  log("grid-mcraft-entity = " .. tostring(settings.startup["grid-mcraft"].value) .. " " .. tostring(mgridw) .. ", " .. tostring(mgridh))

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




data:extend({
-- Equipment
  {
    type = "equipment-grid",
    name = "ecraft-equipment",
    width = 8,
    height = 8,
    equipment_categories = {"armor", "electric-hovercraft-equipment"},
  },
  {
    type = "equipment-grid",
    name = "lcraft-equipment",
    width = 10,
    height = 10,
    equipment_categories = {"armor", "electric-hovercraft-equipment", "lcraft-charger"},
  }
})

if ecraft_activated then
  if mods["bobvehicleequipment"] then
    data.raw["equipment-grid"]["ecraft-equipment"].width = 10
    data.raw["equipment-grid"]["ecraft-equipment"].height = 4
    data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories = { "car", "vehicle", "electric-hovercraft-equipment" }
  end
end

--------------------------------------------------------------------------------------------------------------------
if lcraft_activated then
  data:extend({
    --equipment
    {
      type = "battery-equipment",
      name = "lcraft-charger",
      sprite = {
        filename = HCGRAPHICS .. "equipment/lcraft_charger.png",
        width = 64,
        height = 64,
        priority = "medium",
        scale = 0.5,
      },
      shape = {
        width = 1,
        height = 1,
        type = "full"
      },
      energy_source = {
        type = "electric",
        buffer_capacity = "2250KJ",
        input_flow_limit = "750KW",
        drain = "0W",
        output_flow_limit = "0W",
        usage_priority = "primary-input"
      },
      categories = {"armor"},
      order = "b-i-c"
    }
  })


  if mods["bobvehicleequipment"] then
    data.raw["equipment-grid"]["lcraft-equipment"].width = 10
    data.raw["equipment-grid"]["lcraft-equipment"].height = 6
    data.raw["equipment-grid"]["lcraft-equipment"].equipment_categories = { "tank", "vehicle", "armoured-vehicle", "electric-hovercraft-equipment", "lcraft-charger" }
    data.raw["battery-equipment"]["lcraft-charger"].categories = { "lcraft-charger" }
  end
end

--------------------------------------------------------------------------------------------------------------------
if electriccraft_equipment_activated then
  local ehvt_equipment = table.deepcopy(data.raw["battery-equipment"]["battery-equipment"])
  ehvt_equipment.name = "ehvt-equipment"
  ehvt_equipment.sprite = {
    filename = HCGRAPHICS .. "equipment/ehvt-equipment.png",
    width = 128, --128
    height = 192, --128
    priority = "medium",
    scale = 0.5,
  }
  ehvt_equipment.shape = {
    width = 2,
    height = 3,
    type = "full"
  }
  ehvt_equipment.energy_source = {
    type = "electric",
    buffer_capacity = "200MJ", --math.ceil(500 / 60) .. "MW",
    input_flow_limit = "1GW", --500 .. "MW",
    output_flow_limit = "1GW", --"0W",
    usage_priority = "primary-input"
  }
  ehvt_equipment.categories = {"electric-hovercraft-equipment"}
  data:extend({ehvt_equipment})
end
