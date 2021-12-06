require("constants")

local mod_lasertank_active = mods["laser_tanks"] or mods["laser_tanks_updated"] or false
local mod_elec_engine_active = mod_lasertank_active and settings.startup["lasertanks-electric-engine"] and settings.startup["lasertanks-electric-engine"].value or false

mcraft_activated = settings.startup["enable-mcraft"].value
ecraft_activated = mod_elec_engine_active and settings.startup["enable-ecraft"].value or false
lcraft_activated = mod_lasertank_active and settings.startup["enable-lcraft"].value or false
electriccraft_equipment_activated = mod_lasertank_active and (ecraft_activated or lcraft_activated) or false

require("prototypes.categories")
require("prototypes.equipment")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.technology")
require("prototypes.effects")

if ecraft_activated then
  table.remove(data.raw.recipe["ehvt-equipment"].ingredients, 2)
  table.insert(data.raw.recipe["ehvt-equipment"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
end

-- Manages changes if the electric hovercraft is disabled
if mod_lasertank_active and not ecraft_activated and lcraft_activated then --settings.startup["enable-ecraft"].value or
  table.remove(data.raw.technology["lcraft-tech"].prerequisites, 4)
  table.insert(data.raw.technology["lcraft-tech"].prerequisites, "hcraft-tech")
  table.insert(data.raw.technology["lcraft-tech"].effects, {type = "unlock-recipe", recipe = "ehvt-equipment"})
  table.remove(data.raw.recipe["lcraft-recipe"].ingredients, 1)
  table.insert(data.raw.recipe["lcraft-recipe"].ingredients, {"hcraft-entity", 1})
  data.raw["item-with-entity-data"]["lcraft-entity"].icon = HCGRAPHICS .. "icons/hovercraft_lcraft_fueled_icon.png"
  data.raw["item-with-entity-data"]["lcraft-entity"].icon_size = 64
  table.remove(data.raw.technology["lcraft-tech"].effects, 2)
  data.raw.car["lcraft-entity"].effectivity = 1
  data.raw.car["lcraft-entity"].consumption = "640kW"
  data.raw.car["lcraft-entity"].burner = {
    fuel_category = "chemical",
    effectivity = 1,
    fuel_inventory_size = 2,
    smoke = {
      {
        name = "car-smoke",
        deviation = {0.25, 0.25},
        frequency = 200,
        position = {0, 1.5},
        starting_frame = 0,
        starting_frame_deviation = 60
      }
    }
  }
  data.raw.car["lcraft-entity"].sound_no_fuel = {
    {
      filename = "__base__/sound/fight/car-no-fuel-1.ogg",
      volume = 0.6
    }
  }
  data.raw.car["lcraft-entity"].working_sound = car_sounds
end
