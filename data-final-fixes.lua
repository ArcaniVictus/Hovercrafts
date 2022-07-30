require("constants")
local collision_mask_util = require("__core__.lualib.collision-mask-util")

hcraft_entities = {
  ["hovercraft-collision"] = true,
  ["hcraft-entity"] = true,
  ["mcraft-entity"] = true,
  ["ecraft-entity"] = true,
  ["lcraft-entity"] = true,
}

local prototypes = collision_mask_util.collect_prototypes_with_layer("player-layer")

local hcraft_layer = collision_mask_util.get_first_unused_layer()

for _, prototype in pairs(prototypes) do
  if prototype.type ~= "tile" and not hcraft_entities[prototype.name] then
    local prototype_mask = collision_mask_util.get_mask(prototype)
    table.insert(prototype_mask, hcraft_layer)
    prototype.collision_mask = prototype_mask
  end
end

for name, _ in pairs(hcraft_entities) do
  local prototype = data.raw.car[name]
  if prototype then
    collision_mask_util.remove_layer(prototype.collision_mask, "player-layer")
    collision_mask_util.add_layer(prototype.collision_mask, hcraft_layer)
  end
end


local burner_hcrafts = {
  data.raw["car"]["hcraft-entity"],
  data.raw["car"]["mcraft-entity"],
}

if mods["IndustrialRevolution"] then
  for _, prototype in pairs(burner_hcrafts) do
    if prototype and prototype.burner then
      prototype.burner.fuel_category = nil
      prototype.burner.fuel_categories = {"chemical", "battery"}
      prototype.burner.burnt_inventory_size = 1
    end
  end
end

if mods["Krastorio2"] then
  for _, prototype in pairs(burner_hcrafts) do
    if prototype and prototype.burner then
      prototype.burner.fuel_category = nil
      prototype.burner.fuel_categories = {"vehicle-fuel"}
      prototype.burner.burnt_inventory_size = 1
    end
  end
end
