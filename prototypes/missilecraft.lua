-- hovercraft
-- prototypes.missilecraft


-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"

if mods["SchallTransportGroup"] then
	subgroup_hc = "hovercrafts"
end


-- Missile-craft
local missilecraft_entity = table.deepcopy(data.raw["car"]["hovercraft-entity"])
local updates = {
	name = "missilecraft",
	braking_power = "1500kW",
	consumption = "450kW",
	effectivity = 1.1,
	max_health = 1200,
	rotation_speed = 0.0045,
    tank_driving = true,
	immune_to_tree_impacts = true,
	weight = 10000,
    minable = {mining_time = 0.5, result = "missilecraft"},
	resistances =
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
        decrease = 50,
        percent = 55
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 70
      },
      {
        type = "acid",
        decrease = 0,
        percent = 35
      }
    },
	burner =
    {
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
	guns = {
        "vehicle-missile-turret"
    },
	turret_animation =
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
    },
    turret_rotation_speed = 0.40 / 60,
    turret_return_timeout = 300,
}

for k,v in pairs(updates) do
	missilecraft_entity[k] = updates[k]
end

-- Missile Turret
missile_turret = {
  attack_parameters = {
	ammo_category = "rocket",
	cooldown = 300,
	movement_slow_down_factor = 0.8,
	projectile_center = {
	  -0.17000000000000002,
	  0
	},
	projectile_creation_distance = 0.6,
	range = 30,
	sound = {
	  {
		filename = "__base__/sound/fight/rocket-launcher.ogg",
		volume = 0.7
	  }
	},
	type = "projectile"
  },
  flags = {"hidden"
  },
  icon = "__Hovercrafts__/graphics/icons/missile-turret.png",
  icon_size = 32,
  name = "vehicle-missile-turret",
  order = "d[rocket-launcher]",
  stack_size = 1,
  subgroup = "gun",
  type = "gun"
}


-- Item
local missilecraft_item = {
	type = "item-with-entity-data",
	name = "missilecraft",
	icon = "__Hovercrafts__/graphics/icons/missile_small.png",
	icon_size = 32,
	subgroup = subgroup_hc, --"transport2",
	order = "b[personal-transport]-d[missilecraft]",
	stack_size = 1,
	place_result = "missilecraft"	
}


-- Tech
local missilecraft_tech = {
	type = "technology",
	name = "missilecraft",
	icon = "__Hovercrafts__/graphics/icons/missile-tech.png",
	icon_size = 128,
	effects =
	{
		{type = "unlock-recipe", recipe = "missilecraft"},
	},
	prerequisites = {"hovercraft-tech", "turrets", "rocketry"},
	unit =
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
	},
	order = "a"
}


-- Recipe
local missilecraft_recipe = {
	type = "recipe",
	name = "missilecraft",
	energy_required = 10,
	enabled = false,
	ingredients =
	{
        {"hovercraft-item", 1},
		{"advanced-circuit", 40},
        {"gun-turret", 2},
        {"rocket-launcher", 16}
    },
	result = "missilecraft",
	result_count = 1
}

-- Support for Vortik's Armor Plating mod
if mods["vtk-armor-plating"] then
	   table.insert(missilecraft_recipe.ingredients, {"vtk-armor-plating", 12})
end

data:extend({
	missilecraft_tech,
	missilecraft_recipe,
	missilecraft_item,
	missilecraft_entity,
	missile_turret
})