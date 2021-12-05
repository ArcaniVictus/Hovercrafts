-- data.lua
require("constants")
require("prototypes.categories")
require("prototypes.equipment")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.technology")
require("prototypes.effects")

-- Checks mods/settings and handles electric hovercraft

function make_ecraft()

  -- Ecraft entity
  local ecraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
  ecraft_entity.name = "ecraft-entity"
  ecraft_entity.icon = HCGRAPHICS .. "icons/ecraft_small.png"
  ecraft_entity.icon_size = 64
  ecraft_entity.braking_power = "1000kW"
  ecraft_entity.consumption = "6MW"
  ecraft_entity.effectivity = 0.11
  ecraft_entity.max_health = 250
  ecraft_entity.rotation_speed = 0.0075
  ecraft_entity.weight = 1500
  ecraft_entity.minable = {mining_time = 0.5, result = "ecraft-entity"}
  ecraft_entity.equipment_grid = "ecraft-equipment"
  ecraft_entity.sound_no_fuel = {
    {
      filename = "__Hovercrafts__/audio/no-energy.ogg",
      volume = 0.4
    }
  }
  ecraft_entity.working_sound = {
    sound =
    {
      filename = "__Hovercrafts__/audio/vehicle-motor.ogg",
      volume = 0.5
    },
    match_speed_to_activity = false
  }
  ecraft_entity.burner =
  {
    effectivity = nil,
    fuel_inventory_size = 0,
  }

  -- Item
  local ecraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
  ecraft_item.name = "ecraft-entity"
  ecraft_item.icon = HCGRAPHICS .. "icons/ecraft_small.png"
  ecraft_item.icon_size = 64
  ecraft_item.icon_mipmaps = 0
  ecraft_item.order = "b[personal-transport]-e[ecraft-item]"
  ecraft_item.place_result = "ecraft-entity"

  -- Recipe
  local ecraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])
  ecraft_recipe.name = "ecraft-recipe"
  ecraft_recipe.ingredients = {
    {"low-density-structure", 25},
    {"electric-engine-unit", 40},
    {"processing-unit", 20},
    {"hcraft-entity", 1},
  }
  ecraft_recipe.result = "ecraft-entity"

  -- Tech
  local ecraft_tech = table.deepcopy(data.raw.technology["hcraft-tech"])
  ecraft_tech.name = "ecraft-tech"
  ecraft_tech.icon = HCGRAPHICS .. "technology/ecraft_large.png"
  ecraft_tech.icon_size = 256
  ecraft_tech.effects = {
    {
      type = "unlock-recipe",
      recipe = "ecraft-recipe"
    },
    {
      type = "unlock-recipe",
      recipe = "ehvt-equipment",
    },
  }
  ecraft_tech.prerequisites = {"hcraft-tech"} --, "electric-vehicles-high-voltage-transformer"
  ecraft_tech.unit = {
    count = 400,
    ingredients =
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"utility-science-pack", 1},
    },
    time = 60
  }
  data:extend({
    ecraft_entity,
    ecraft_item,
    ecraft_tech,
    ecraft_recipe
  })
end

-- Checks mods/settings and handles Extra high voltage transformer

function make_equipment()
  local ehvt_equipment = table.deepcopy(data.raw["battery-equipment"]["battery-equipment"])
  local ehvt_item = table.deepcopy(data.raw.item["battery"])
  local ehvt_recipe = table.deepcopy(data.raw.recipe["battery-equipment"])

  -- Equipment
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

  -- Item
  ehvt_item.name = "ehvt-equipment"
  ehvt_item.icon = HCGRAPHICS .. "icons/ehvt-item.png"
  ehvt_item.icon_size = 64
  ehvt_item.icon_mipmaps = 0
  ehvt_item.placed_as_equipment_result = "ehvt-equipment"
  ehvt_item.subgroup = subgroup_hovercrafts_ehvt
  ehvt_item.order = "d2"
  ehvt_item.stack_size = 10

  -- Recipe
  ehvt_recipe.name = "ehvt-equipment"
  ehvt_recipe.category = "crafting-with-fluid"
  ehvt_recipe.ingredients = {
    {"battery-mk2-equipment", 2},
    {"processing-unit", 5},
    {type = "fluid", name = "lubricant", amount = 50},
  }
  ehvt_recipe.result = "ehvt-equipment"

  data:extend({
    ehvt_equipment,
    ehvt_item,
    ehvt_recipe
  })
end

-- Checks mods/settings and handles laser-craft
function make_lcraft()
  local lcraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
  local lcraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
  local lcraft_tech = table.deepcopy(data.raw.technology["hcraft-tech"])
  local lcraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])

  -- lcraft entity
  lcraft_entity.name = "lcraft-entity"
  lcraft_entity.icon = HCGRAPHICS .. "icons/lcraft_small_elec.png"
  lcraft_entity.icon_size = 64
  lcraft_entity.effectivity = 0.20
  lcraft_entity.max_health = 800
  lcraft_entity.rotation_speed = 0.0050
  lcraft_entity.weight = 7500
  lcraft_entity.minable = {mining_time = 0.5, result = "lcraft-entity"}
  lcraft_entity.equipment_grid = "lcraft-equipment"
  lcraft_entity.immune_to_tree_impacts = true
  --lcraft_entity.immune_to_rock_impacts = true
  lcraft_entity.burner =
  {
    effectivity = nil,
    fuel_inventory_size = 0,
  }
  lcraft_entity.braking_power = "1250kW"
  lcraft_entity.consumption = "8MW"
  lcraft_entity.sound_no_fuel = {
    {
      filename = "__Hovercrafts__/audio/no-energy.ogg",
      volume = 0.4
    }
  }
  lcraft_entity.working_sound = {
    sound = {
      filename = "__Hovercrafts__/audio/vehicle-motor.ogg",
      volume = 0.5
    },
    match_speed_to_activity = false
  }
  lcraft_entity.resistances = {
    {
      type = "fire",
      decrease = 7.5,
      percent = 30
    },
    {
      type = "physical",
      decrease = 7.5,
      percent = 30
    },
    {
      type = "impact",
      decrease = 40,
      percent = 75
    },
    {
      type = "explosion",
      decrease = 7.5,
      percent = 35
    },
    {
      type = "acid",
      decrease = 0,
      percent = 35
    }
  }
  lcraft_entity.guns = {"vehicle-laser-gun"}
  lcraft_entity.turret_rotation_speed = 0.35 / 60
  lcraft_entity.turret_animation = {
    layers = {
      {
        filename = "__base__/graphics/entity/car/car-turret.png",
        priority = "low",
        line_length = 8,
        width = 36,
        height = 29,
        frame_count = 1,
        direction_count = 64,
        shift = {0.03125, -0.890625},
        animation_speed = 8,
        hr_version =
        {
          priority = "low",
          width = 71,
          height = 57,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = util.by_pixel(0+2, -33.5+8.5),
          animation_speed = 8,
          scale = 0.5,
          stripes = {
            {
              filename = "__base__/graphics/entity/car/hr-car-turret-1.png",
              width_in_frames = 1,
              height_in_frames = 32
            },
            {
              filename = "__base__/graphics/entity/car/hr-car-turret-2.png",
              width_in_frames = 1,
              height_in_frames = 32
            }
          }
        }
      },
      {
        filename = "__base__/graphics/entity/car/car-turret-shadow.png",
        priority = "low",
        line_length = 8,
        width = 46,
        height = 31,
        frame_count = 1,
        draw_as_shadow = true,
        direction_count = 64,
        shift = {0.875, 0.359375}
      }
    }
  }

  -- Item
  lcraft_item.name = "lcraft-entity"
  lcraft_item.icon = HCGRAPHICS .. "icons/lcraft_small_elec.png"
  lcraft_item.icon_size = 64
  lcraft_item.icon_mipmaps = 0
  lcraft_item.subgroup = subgroup_hovercrafts
  lcraft_item.order = "d[personal-transport]-d"
  lcraft_item.place_result = "lcraft-entity"

  -- Tech
  lcraft_tech.name = "lcraft-tech"
  lcraft_tech.icon = HCGRAPHICS .. "technology/lcraft_large_elec.png"
  lcraft_tech.icon_size = 256
  lcraft_tech.effects = {
    {
      type = "unlock-recipe",
      recipe = "lcraft-recipe"
    },
    {
      type = "unlock-recipe",
      recipe = "lcraft-charger"
    },
  }
  lcraft_tech.prerequisites = {"laser-turret", "laser-rifle-2", "nuclear-power", "ecraft-tech"}
  lcraft_tech.unit = {
    count = 400,
    ingredients =
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"military-science-pack", 1},
      {"utility-science-pack", 1},
    },
    time = 60
  }
  -- Recipe
  lcraft_recipe.name = "lcraft-recipe"
  lcraft_recipe.ingredients = {
    {"ecraft-entity", 1},
    {"laser-turret", 2},
    {"heat-pipe", 25},
    {"heat-exchanger", 2},
  }
  lcraft_recipe.result = "lcraft-entity"

  data:extend({
    lcraft_entity,
    lcraft_item,
    lcraft_tech,
    lcraft_recipe
  })
end


if settings.startup["enable-ecraft"].value and (mods["electric-vehicles-lib-reborn"] or mods["laser_tanks"] and settings.startup["lasertanks-electric-engine"] and settings.startup["lasertanks-electric-engine"].value) then
  make_ecraft()
end

if mods["electric-vehicles-lib-reborn"] or mods["laser_tanks"] then
  if settings.startup["enable-ecraft"].value or settings.startup["enable-lcraft"].value then
    make_equipment()
  end
end

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

if mods["laser_tanks"] and settings.startup["enable-lcraft"].value then

  make_lcraft()

  data:extend({
    --recipe
    {
      type = "recipe",
      name = "lcraft-charger",
      enabled = false,
      energy_required = 10,
      ingredients = {
        {"processing-unit", 25},
        {"energy-shield-mk2-equipment", 5},
        {"ehvt-equipment", 2}
      },
      result = "lcraft-charger"
    },
    --item
    {
      type = "item",
      name = "lcraft-charger",
      icon = HCGRAPHICS .. "icons/lcraft_charger-icon.png",
      icon_size = 64,
      flags = {},
      placed_as_equipment_result = "lcraft-charger",
      subgroup = "equipment",
      order = "e[robotics]-a[personal-roboport-equipment]",
      stack_size = 20
    },
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
end

if mods["SchallTransportGroup"] then
  if data.raw.item["lcraft-charger"] then
    data.raw["item"]["lcraft-charger"].subgroup = "vehicle-equipment"
    data.raw["item"]["lcraft-charger"].order = "e2"
  end
end

-- Support for Bob Vehicle Equipment mod
if mods["bobvehicleequipment"] then
  if data.raw["item-with-entity-data"]["ecraft-entity"] then
    data.raw["equipment-grid"]["ecraft-equipment"].width = 10
    data.raw["equipment-grid"]["ecraft-equipment"].height = 4
    data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories = { "car", "vehicle", "electric-hovercraft-equipment" }
  end
  if data.raw["item-with-entity-data"]["lcraft-entity"] then
    data.raw["equipment-grid"]["lcraft-equipment"].width = 10
    data.raw["equipment-grid"]["lcraft-equipment"].height = 6
    data.raw["equipment-grid"]["lcraft-equipment"].equipment_categories = { "tank", "vehicle", "armoured-vehicle", "electric-hovercraft-equipment", "lcraft-charger" }
    data.raw["battery-equipment"]["lcraft-charger"].categories = { "lcraft-charger" }
  end
end

-- Support for Vortik's Armor Plating mod
if mods["vtk-armor-plating"] then
  if data.raw["item-with-entity-data"]["ecraft-entity"] then
    table.insert(data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories, "vtk-armor-plating")
  end
  if data.raw["item-with-entity-data"]["lcraft-entity"] then -- settings.startup["enable-lcraft"].value then
    table.insert(data.raw["equipment-grid"]["lcraft-equipment"].equipment_categories, "vtk-armor-plating")
    table.insert(data.raw.recipe["lcraft-recipe"].ingredients, {"vtk-armor-plating", 8})
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
    data.raw["item-with-entity-data"]["lcraft-entity"].icon = HCGRAPHICS .. "icons/lcraft_small_burn.png"
    data.raw["item-with-entity-data"]["lcraft-entity"].icon_size = 64
    data.raw.technology["lcraft-tech"].icon = HCGRAPHICS .. "technology/lcraft_large_burn.png"
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
