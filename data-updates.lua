-- data-updates.lua
require("constants")

--[[if mods["justgo"] then
  local function generate_migration_item(name) -- not sure if the "just go" dude will fix it...
    if data.raw["item-with-entity-data"][name] then
      local temp = table.deepcopy(data.raw["item-with-entity-data"][name])
      temp.name = temp.name:sub(1,-7).."item"
      log(temp.name)
      data:extend({temp})
    end
  end

  generate_migration_item("hovercraft")
  generate_migration_item("missile-hovercraft")
  generate_migration_item("electric-hovercraft")
  generate_migration_item("laser-hovercraft")
end]]
