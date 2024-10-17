require("constants")

local mod_lasertank_active = mods["laser_tanks"] or mods["laser_tanks_updated"] or false
local mod_elec_engine_active = mod_lasertank_active and settings.startup["lasertanks-electric-engine"] and settings.startup["lasertanks-electric-engine"].value or false

missile_hovercraft_activated = settings.startup["enable-missile-hovercraft"].value
electric_hovercraft_activated = mod_elec_engine_active and settings.startup["enable-electric-hovercraft"].value or false
laser_hovercraft_activated = mod_lasertank_active and settings.startup["enable-laser-hovercraft"].value or false
electriccraft_equipment_activated = mod_lasertank_active and (electric_hovercraft_activated or laser_hovercraft_activated) or false

require("prototypes.categories")
require("prototypes.equipment")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.technology")
require("prototypes.effects")

if electric_hovercraft_activated then
  table.remove(data.raw.recipe["ehvt-equipment"].ingredients, 2)
  table.insert(data.raw.recipe["ehvt-equipment"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
end

-- Manages changes if the electric hovercraft is disabled
if mod_lasertank_active and not electric_hovercraft_activated and laser_hovercraft_activated then --settings.startup["enable-electric-hovercraft"].value or
  table.remove(data.raw.technology["laser-hovercraft"].prerequisites, 4)
  table.insert(data.raw.technology["laser-hovercraft"].prerequisites, "hovercraft")
  table.insert(data.raw.technology["laser-hovercraft"].effects, {type = "unlock-recipe", recipe = "ehvt-equipment"})
  table.remove(data.raw.recipe["laser-hovercraft"].ingredients, 1)
  table.insert(data.raw.recipe["laser-hovercraft"].ingredients, {"hovercraft", 1})
  data.raw["item-with-entity-data"]["laser-hovercraft"].icon = HCGRAPHICS .. "icons/hovercraft_lcraft_fueled_icon.png"
  data.raw["item-with-entity-data"]["laser-hovercraft"].icon_size = 64
  table.remove(data.raw.technology["laser-hovercraft"].effects, 2)
  data.raw.car["laser-hovercraft"].effectivity = 1
  data.raw.car["laser-hovercraft"].consumption = "640kW"
  data.raw.car["laser-hovercraft"].energy_source = {
    type = "burner",
    fuel_categories = {"chemical"},
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
  data.raw.car["laser-hovercraft"].sound_no_fuel = {
    {
      filename = "__base__/sound/fight/car-no-fuel-1.ogg",
      volume = 0.6
    }
  }
  data.raw.car["laser-hovercraft"].working_sound = car_sounds
end
