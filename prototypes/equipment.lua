----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------EQUIPMENT GRID----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

local hgridw, hgridh = string.match(settings.startup["hovercraft-grid-size"].value, "(%d+)x(%d+)")
log("grid-hovercraft = " .. tostring(settings.startup["hovercraft-grid-size"].value) .. " " .. tostring(hgridw) .. ", " .. tostring(hgridh))

data:extend({
  {
    type = "equipment-grid",
    name = "hovercraft-equipment",
    width = tonumber(hgridw) or 2,
    height = tonumber(hgridh) or 2,
    equipment_categories = {"armor"}
  }
})

if mods["bobvehicleequipment"] then
  data.raw["equipment-grid"]["hovercraft-equipment"].equipment_categories = {"car", "vehicle"}
end
if mods["vtk-armor-plating"] then
  table.insert(data.raw["equipment-grid"]["hovercraft-equipment"].equipment_categories, "vtk-armor-plating")
end

----------------------------------------------------------------------------------------------------------------------------------
if missile_hovercraft_activated then
  local mgridw, mgridh = string.match(settings.startup["missile-hovercraft-grid-size"].value, "(%d+)x(%d+)")
  log("grid-missile-hovercraft = " .. tostring(settings.startup["missile-hovercraft-grid-size"].value) .. " " .. tostring(mgridw) .. ", " .. tostring(mgridh))

  data:extend({
    {
      type = "equipment-grid",
      name = "missile-hovercraft-equipment",
      width = tonumber(mgridw) or 4,
      height = tonumber(mgridh) or 2,
      equipment_categories = {"armor"}
    }
  })

  if mods["bobvehicleequipment"] then
    data.raw["equipment-grid"]["missile-hovercraft-equipment"].equipment_categories = {"tank", "vehicle", "armoured-vehicle"}
  end
  if mods["vtk-armor-plating"] then
    table.insert(data.raw["equipment-grid"]["missile-hovercraft-equipment"].equipment_categories, "vtk-armor-plating")
  end
end

----------------------------------------------------------------------------------------------------------------------------------
if electric_hovercraft_activated then
  data:extend({
    {
      type = "equipment-grid",
      name = "ecraft-equipment",
      width = 8,
      height = 8,
      equipment_categories = {"armor", "electric-hovercraft-equipment"},
    },
  })

  if mods["bobvehicleequipment"] then
    data.raw["equipment-grid"]["ecraft-equipment"].width = 10
    data.raw["equipment-grid"]["ecraft-equipment"].height = 4
    data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories = {"car", "vehicle", "electric-hovercraft-equipment"}
  end
  if mods["vtk-armor-plating"] then
    table.insert(data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories, "vtk-armor-plating")
  end
end

----------------------------------------------------------------------------------------------------------------------------------
if laser_hovercraft_activated then
  data:extend({
    {
      type = "equipment-grid",
      name = "lcraft-equipment",
      width = 10,
      height = 10,
      equipment_categories = {"armor", "electric-hovercraft-equipment", "lcraft-charger"},
    }
  })

  if mods["bobvehicleequipment"] then
    data.raw["equipment-grid"]["lcraft-equipment"].width = 10
    data.raw["equipment-grid"]["lcraft-equipment"].height = 6
    data.raw["equipment-grid"]["lcraft-equipment"].equipment_categories = {"tank", "vehicle", "armoured-vehicle", "electric-hovercraft-equipment", "lcraft-charger"}
  end
  if mods["vtk-armor-plating"] then
    table.insert(data.raw["equipment-grid"]["lcraft-equipment"].equipment_categories, "vtk-armor-plating")
  end
end

----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------EQUIPEMENT------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

if laser_hovercraft_activated then
  data:extend({
    {
      type = "battery-equipment",
      name = "lcraft-charger",
      sprite = {
        filename = HCGRAPHICS .. "equipment/equipment-lcraft-charger.png",
        width = 64,
        height = 64,
        scale = 0.5,
      },
      shape = {
        width = 1,
        height = 1,
        type = "full",
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
    data.raw["battery-equipment"]["lcraft-charger"].categories = {"lcraft-charger"}
  end
end

----------------------------------------------------------------------------------------------------------------------------------
if electriccraft_equipment_activated then
  data:extend({
    {
      type = "battery-equipment",
      name = "ehvt-equipment",
      sprite = {
        filename = HCGRAPHICS .. "equipment/equipment-ehvt.png",
        width = 128,
        height = 192,
        scale = 0.5,
      },
      shape = {
        width = 2,
        height = 3,
        type = "full",
      },
      energy_source = {
        type = "electric",
        buffer_capacity = "200MJ",
        input_flow_limit = "1GW",
        output_flow_limit = "1GW",
        usage_priority = "primary-input"
      },
      categories = {"electric-hovercraft-equipment"}
    },
  })
end
