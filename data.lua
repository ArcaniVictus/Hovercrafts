-- data.lua
require("constants")


-- Checks mods/settings and handles electric hovercraft

mod_lasertank_active = mods["laser_tanks"] or mods["laser_tanks_updated"] or false

mcraft_activated = false
ecraft_activated = false
lcraft_activated = false
electriccraft_equipment_activated = false

if settings.startup["enable-mcraft"].value then
  mcraft_activated = true
end

if settings.startup["enable-ecraft"].value then
  if mods["electric-vehicles-lib-reborn"] or (mod_lasertank_active and settings.startup["lasertanks-electric-engine"] and settings.startup["lasertanks-electric-engine"].value) then
    ecraft_activated = true
  end
end

if settings.startup["enable-lcraft"].value then
  if mod_lasertank_active then
    lcraft_activated = true
  end
end

if settings.startup["enable-ecraft"].value or settings.startup["enable-lcraft"].value then
  if mods["electric-vehicles-lib-reborn"] or mod_lasertank_active then
    electriccraft_equipment_activated = true
  end
end

require("prototypes.categories")
require("prototypes.equipment")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.technology")
require("prototypes.effects")


-- Support for PiteR's Electric Vehicles Reborn mod
if mods["electric-vehicles-reborn"] then
  if settings.startup["enable-ecraft"].value then
    table.remove(data.raw.recipe["ehvt-equipment"].ingredients, 2)
    table.insert(data.raw.recipe["ehvt-equipment"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
    if data.raw["item-with-entity-data"]["ecraft-entity"] then
    table.insert(data.raw.technology["ecraft-tech"].prerequisites, "electric-vehicles-high-voltage-transformer" )
    end
  end
end

-- Manages changes if the electric hovercraft is disabled
if data.raw["item-with-entity-data"]["ecraft-entity"] == nil and settings.startup["enable-lcraft"].value and data.raw["item-with-entity-data"]["lcraft-entity"] then --settings.startup["enable-ecraft"].value or
  table.remove(data.raw.technology["lcraft-tech"].prerequisites, 4)
  table.insert(data.raw.technology["lcraft-tech"].prerequisites, "hcraft-tech")
  table.remove(data.raw.recipe["lcraft-recipe"].ingredients, 1)
  table.insert(data.raw.recipe["lcraft-recipe"].ingredients, {"hcraft-entity", 1})
  table.insert(data.raw.technology["lcraft-tech"].effects, {type = "unlock-recipe", recipe = "ehvt-equipment"})
  if mods["electric-vehicles-reborn"] then
    table.remove(data.raw.recipe["ehvt-equipment"].ingredients, 2)
    table.insert(data.raw.recipe["ehvt-equipment"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
    table.insert(data.raw.technology["lcraft-tech"].prerequisites, "electric-vehicles-high-voltage-transformer" )
  end
  if settings.startup["lasertanks-electric-engine"] and mods["electric-vehicles-reborn"] == nil then
    data.raw["item-with-entity-data"]["lcraft-entity"].icon = HCGRAPHICS .. "icons/hovercraft_lcraft_fueled_icon.png"
    data.raw["item-with-entity-data"]["lcraft-entity"].icon_size = 64
    data.raw.technology["lcraft-tech"].icon = HCGRAPHICS .. "technology/lcraft_burner_tech.png"
    data.raw.technology["lcraft-tech"].icon_size = 256
    if settings.startup["lasertanks-electric-engine"].value == false then
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
  end
end

if settings.startup["lasertanks-electric-engine"] and settings.startup["lasertanks-electric-engine"].value then
  if mods["electric-vehicles-reborn"] == nil then
    table.remove(data.raw.recipe["ehvt-equipment"].ingredients, 2)
    table.insert(data.raw.recipe["ehvt-equipment"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
  end
end
