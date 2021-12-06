-- data-updates.lua
require("constants")

-- add equipment grid to hovercraft and mcraft-entity if startup setting selected
if settings.startup["hovercraft-grid"].value then
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

--[[if mods["justgo"] then
  local function generate_migration_item(name) -- not sure if the "just go" dude will fix it...
    if data.raw["item-with-entity-data"][name] then
      local temp = table.deepcopy(data.raw["item-with-entity-data"][name])
      temp.name = temp.name:sub(1,-7).."item"
      log(temp.name)
      data:extend({temp})
    end
  end

  generate_migration_item("hcraft-entity")
  generate_migration_item("mcraft-entity")
  generate_migration_item("ecraft-entity")
  generate_migration_item("lcraft-entity")
end]]
