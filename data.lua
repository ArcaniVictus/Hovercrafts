-- Hovercraft
-- data.lua


require("prototypes.categories")
require("prototypes.equipment")
require("prototypes.hovercraft")
require("prototypes.swimming")
require("prototypes.missilecraft")

-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"
local subgroup_ehvt = "electric-vehicles-equipment"


if mods["SchallTransportGroup"] then
	subgroup_hc = "hovercrafts"
	subgroup_ehvt = "vehicle-equipment"
	--table.insert(data.raw["item-with-entity-data"]["ecraft-item"].subgroup, "hovercrafts")
	--table.insert(data.raw["item"]["extra-high-voltage-transformer"].subgroup, "vehicle-equipment" )
end

-- collision box
local collision = table.deepcopy(data.raw.car.car)
    collision.collision_box[1][1]=collision.collision_box[1][1]*1.2
    collision.collision_box[1][2]=collision.collision_box[1][2]*1.2
    collision.collision_box[2][1]=collision.collision_box[2][1]*1.2
    collision.collision_box[2][2]=collision.collision_box[2][2]*1.2
    collision.name="hovercraft-collision"
    collision.order="hovercraft-collision"
data:extend({collision})
	
	
-- Checks for mod, Electric vehicles reborn, and if true inserts electric hovercraft
if mods["electric-vehicles-lib-reborn"] then
-- Ecraft entity
local ecraft_entity = table.deepcopy(data.raw["car"]["hovercraft-entity"])
local updates = {
	name = "ecraft-entity",
	icon = "__Hovercrafts__/graphics/icons/ecraft_small.png",
	icon_size = 32,	
	braking_power = "1000kW",
	consumption = "6MW",
	effectivity = 0.11, --0.21,
	max_health = 250,
	rotation_speed = 0.0075,
	weight = 1500,
	minable = {mining_time = 0.5, result = "ecraft-item"},
	equipment_grid = "ecraft-equipment",
	inventory_size = 80,
	sound_no_fuel =
    {
      {
        filename = "__Hovercrafts__/audio/no-energy.ogg",
        volume = 0.4
      }
    },
	working_sound =
    {
      sound =
      {
        filename = "__Hovercrafts__/audio/vehicle-motor.ogg",
        volume = 0.5
      },
	  match_speed_to_activity = false
    },
	burner =
    {
      effectivity = nil,
      fuel_inventory_size = 0,
    },
}
for k,v in pairs(updates) do
	ecraft_entity[k] = updates[k]
end


data:extend({
	ecraft_entity,
})	

data:extend({
-- Item
    {
	type = "item-with-entity-data",
	name = "ecraft-item",
	icon = "__Hovercrafts__/graphics/icons/ecraft_small.png",
	icon_size = 32,
	subgroup = subgroup_hc, --"transport2",
	order = "b[personal-transport]-e[ecraft-item]",
	stack_size = 1,
	place_result = "ecraft-entity"	
	},
	{
    type = "item",
    name = "extra-high-voltage-transformer",
    icon = "__Hovercrafts__/graphics/extra-high-voltage-transformer-icon.png",
    icon_size = 32,
    placed_as_equipment_result = "extra-high-voltage-transformer",
    flags = {},
    subgroup = subgroup_ehvt, --"electric-vehicles-equipment",
    order = "d",
    stack_size = 10,
	},
	

-- Tech
    {
	type = "technology",
	name = "ecraft-tech",
	icon = "__Hovercrafts__/graphics/icons/ecraft_large.png",
	icon_size = 128,
	effects =
	{
		{
		type = "unlock-recipe",
		recipe = "ecraft-recipe"
		},
		{
        type = "unlock-recipe",
        recipe = "extra-high-voltage-transformer-recipe",
        },
	},
	prerequisites = {"hovercraft-tech"}, --, "electric-vehicles-high-voltage-transformer"
	unit =
	{
		count = 400,
		ingredients =
		{
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"utility-science-pack", 1},
		},
		time = 60
	},
	order = "a"
	},


-- Recipe
    {
	type = "recipe",
	name = "ecraft-recipe",
	energy_required = 10,
	enabled = false,
	ingredients =
	{
		{"low-density-structure", 25},
		{"electric-engine-unit", 40},
		{"processing-unit", 20},
		{"hovercraft-item", 1},
    },
	result = "ecraft-item",
	result_count = 1
	},
	{
    type = "recipe",
    name = "extra-high-voltage-transformer-recipe",
    enabled = false,
    ingredients =
    {
      --{"electric-vehicles-hi-voltage-transformer", 4},--
	  {"battery-mk2-equipment", 2},
	  --{"steel-plate", 150},
      {type = "fluid", name = "lubricant", amount = 50},
    },
    result = "extra-high-voltage-transformer",
    category = "crafting-with-fluid",
	
	},
	
	

-- Equipment
    {
	type = "equipment-grid",
    name = "ecraft-equipment",
    width = 8,
    height = 8,
    equipment_categories = { "armor", "electric-hovercraft-equipment" },
	},
	{
	type = "battery-equipment",
    name = "extra-high-voltage-transformer",
    sprite =
    {
      filename = "__Hovercrafts__/graphics/extra-high-voltage-transformer-equipment.png",
      width = 64,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 4,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "200MJ", --math.ceil(500 / 60) .. "MW",
      input_flow_limit = "1GW", --500 .. "MW",
      output_flow_limit = "1GW", --"0W",
      usage_priority = "secondary-input"
    },
    categories = {"electric-hovercraft-equipment"},
	},
})
end


-- Support for Vortik's Armor Plating mod
if mods["vtk-armor-plating"] then
	   --table.insert(ecraft_equipment.equipment_categories, "vtk-armor-plating")
	   table.insert(data.raw["equipment-grid"]["ecraft-equipment"].equipment_categories, "vtk-armor-plating")
end


-- Support for PiteR's Electric Vehicles Reborn mod
if mods["electric-vehicles-reborn"] then
	table.insert(data.raw["recipe"]["extra-high-voltage-transformer-recipe"].ingredients, {"electric-vehicles-hi-voltage-transformer", 2})
	table.insert(data.raw["technology"]["ecraft-tech"].prerequisites, "electric-vehicles-high-voltage-transformer" )
end


	-- Checks for mods, Electric vehicles reborn and laser_tanks, and if true inserts laser-craft
-- lcraft entity
if mods["laser_tanks"] then
if mods["electric-vehicles-lib-reborn"] then
local lcraft_entity = table.deepcopy(data.raw["car"]["ecraft-entity"])
local updates = {
	name = "lcraft-entity",
	icon = "__Hovercrafts__/graphics/icons/lcraft_small.png",
	icon_size = 32,	
	braking_power = "1250kW",
	consumption = "8MW",
	effectivity = 0.20, --0.40,
	max_health = 800,
	rotation_speed = 0.0050,
	weight = 7500,
	minable = {mining_time = 0.5, result = "lcraft-item"},
	equipment_grid = "lcraft-equipment",
	inventory_size = 80,
	resistances =
    {
      {
        type = "fire",
        decrease = 5,
        percent = 20
      },
      {
        type = "physical",
        decrease = 7.5,
        percent = 30
      },
      {
        type = "impact",
        decrease = 30,
        percent = 25
      },
      {
        type = "explosion",
        decrease = 7.5,
        percent = 30
      },
      {
        type = "acid",
        decrease = 0,
        percent = 15
      }
    },
	sound_no_fuel =
    {
      {
        filename = "__Hovercrafts__/audio/no-energy.ogg",
        volume = 0.4
      }
    },
	working_sound =
    {
      sound =
      {
        filename = "__Hovercrafts__/audio/vehicle-motor.ogg",
        volume = 0.5
      },
	  match_speed_to_activity = false
    },
	burner =
    {
      effectivity = nil,
      fuel_inventory_size = 0,
    },
	guns = {"vehicle-laser-gun"},
    turret_rotation_speed = 0.35 / 60,
	turret_animation =
    {
      layers =
      {
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
            stripes =
            {
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
    },
}
for k,v in pairs(updates) do
	lcraft_entity[k] = updates[k]
end

-- Item
local lcraft_item = {
	type = "item-with-entity-data",
	name = "lcraft-item",
	icon = "__Hovercrafts__/graphics/icons/lcraft_small.png",
	icon_size = 32,
	subgroup = subgroup_hc, --"transport2",
	order = "d[personal-transport]-d",
	stack_size = 1,
	place_result = "lcraft-entity"	
	}
	

-- Tech
local lcraft_tech = {
	type = "technology",
	name = "lcraft-tech",
	icon = "__Hovercrafts__/graphics/icons/lcraft_large.png",
	icon_size = 128,
	effects =
	{
		{
		type = "unlock-recipe",
		recipe = "lcraft-recipe"
		},
	},
	prerequisites = {"laser-turrets", "laser-rifle-2", "nuclear-power", "ecraft-tech"}, --, "extra-high-voltage-transformer-tech",  "low-density-structure", "advanced-electronics-2"
	unit =
	{
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
	},
	order = "a"
	}
	

-- Recipe
local lcraft_recipe = {
	type = "recipe",
	name = "lcraft-recipe",
	energy_required = 10,
	enabled = false,
	ingredients =
	{
		{"ecraft-item", 1},
        {"laser-turret", 2},
		{"heat-pipe", 25},
		{"heat-exchanger", 2},
    },
	result = "lcraft-item",
	result_count = 1
	}

-- Equipment
local lcraft_equipment = {
	type = "equipment-grid",
    name = "lcraft-equipment",
    width = 10,
    height = 10,
    equipment_categories = {"armor", "electric-hovercraft-equipment"},
	}

--[[ Lcraft gun
local lcraft_gun = table.deepcopy(data.raw.gun["vehicle-laser-gun"])
local updates = {
	name = "lcraft-laser",
    icons = "__Hovercrafts__/graphics/icons/railgun.png",
    icon_size = 32,
	attack_parameters =
      {
      cooldown = 40,
	  range = 24
	  }
	}]]--

-- Support for Vortik's Armor Plating mod
if mods["vtk-armor-plating"] then
	   table.insert(lcraft_equipment.equipment_categories, "vtk-armor-plating")
	   table.insert(lcraft_recipe.ingredients, {"vtk-armor-plating", 8})
end
	
data:extend({
	lcraft_entity,
	lcraft_item,
	lcraft_tech,
	lcraft_recipe,
	lcraft_equipment,
	--lcraft_gun,
})
end
end