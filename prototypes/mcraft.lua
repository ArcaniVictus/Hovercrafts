-- prototypes.mcraft.lua

-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"

if mods["SchallTransportGroup"] then
	subgroup_hc = "hovercrafts"
end


-- Missile-craft
if settings.startup["enable-mcraft"].value then

local mcraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
local mcraft_gun = table.deepcopy(data.raw.gun["vehicle-machine-gun"])
local mcraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
local mcraft_tech = table.deepcopy(data.raw.technology["hcraft-tech"])
local mcraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])

-- Mcraft entity
mcraft_entity.name = "mcraft-entity"
mcraft_entity.braking_power = "1500kW"
mcraft_entity.consumption = "450kW"
mcraft_entity.effectivity = 1.1
mcraft_entity.max_health = 1200
mcraft_entity.rotation_speed = 0.0045
mcraft_entity.tank_driving = true
-- mcraft_entity.immune_to_tree_impacts = true  -- no.. just no
-- mcraft_entity.immune_to_rock_impacts = true  -- no.. just no
mcraft_entity.weight = 10000
mcraft_entity.minable = {mining_time = 0.5, result = "mcraft-entity"}
mcraft_entity.resistances =
    {
      {
        type = "fire",
        decrease = 10,
        percent = 55
      },
      {
        type = "physical",
        decrease = 10,
        percent = 55
      },
      {
        type = "impact",
        decrease = 30, -- from 50
        percent = 65 --from 55
      },
      {
        type = "explosion",
        decrease = 10,
        percent = 65
      },
      {
        type = "acid",
        decrease = 0,
        percent = 55
      }
    }
mcraft_entity.burner =
    {
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 2,
    }
mcraft_entity.guns = {"vehicle-missile-turret"}
mcraft_entity.turret_animation =
    {
      layers =
      {
        {
          filename = "__Hovercrafts__/graphics/vehicle-rocket-sheet2.png",
          line_length = 16,
          width = 88,
          height = 80,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {.05,-.85},
          scale = 0.5,
        }
      }
    }
mcraft_entity.turret_rotation_speed = 0.40 / 60
mcraft_entity.turret_return_timeout = 300

-- Mcraft gun
mcraft_gun.name = "vehicle-missile-turret"
mcraft_gun.icon = "__Hovercrafts__/graphics/icons/missile-turret.png"
mcraft_gun.icon_size = 32
mcraft_gun.order = "d[rocket-launcher]"
mcraft_gun.attack_parameters =
	{
		type = "projectile",
		ammo_category = "rocket",
		cooldown = 300,
		movement_slow_down_factor = 0.9,
		projectile_center = 
			{
			-0.17000000000000002,
			0
			},
		projectile_creation_distance = 0.6,
		range = 30,
		sound =
		{
			{
			filename = "__base__/sound/fight/rocket-launcher.ogg",
			volume = 0.7
			}
		}
	}


-- Mcraft item
mcraft_item.name = "mcraft-entity"
mcraft_item.icon = "__Hovercrafts__/graphics/icons/mcraft_small.png"
mcraft_item.icon_size = 32
mcraft_item.order = "b[personal-transport]-d[mcraft-entity]"
mcraft_item.place_result = "mcraft-entity"	



-- Mcraft tech
mcraft_tech.name = "mcraft-tech"
mcraft_tech.icon = "__Hovercrafts__/graphics/icons/mcraft_large.png"
mcraft_tech.icon_size = 128
mcraft_tech.effects =
	{
		{type = "unlock-recipe", recipe = "mcraft-recipe"},
	}
mcraft_tech.prerequisites = {"hcraft-tech", "turrets", "rocketry"}
mcraft_tech.unit =
	{
		count = 200,
		ingredients =
		{
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"military-science-pack", 1},
		},
		time = 60
	}


-- Mcraft recipe
mcraft_recipe.name = "mcraft-recipe"
mcraft_recipe.ingredients =
	{
        {"hcraft-entity", 1},
		{"advanced-circuit", 40},
        {"gun-turret", 2},
        {"rocket-launcher", 16}
    }
mcraft_recipe.result = "mcraft-entity"

-- Support for Vortik's Armor Plating mod
if mods["vtk-armor-plating"] then
	   table.insert(mcraft_recipe.ingredients, {"vtk-armor-plating", 12})
end

data:extend({
	mcraft_entity,
	mcraft_gun,
	mcraft_item,
	mcraft_tech,
	mcraft_recipe
})
end