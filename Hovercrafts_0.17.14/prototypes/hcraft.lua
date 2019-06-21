-- prototypes.hcraft.lua

-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"

if mods["SchallTransportGroup"] then
	subgroup_hc = "hovercrafts"
end


local hcraft_entity = table.deepcopy(data.raw.car.car)
local hcraft_item = table.deepcopy(data.raw["item-with-entity-data"].car)
local hcraft_tech = table.deepcopy(data.raw.technology.automobilism)
local hcraft_recipe = table.deepcopy(data.raw.recipe.car)
local hover_smoke = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])

-- Hovercraft entity
hcraft_entity.name = "hcraft-entity"
hcraft_entity.icon = "__Hovercrafts__/graphics/icons/hcraft_small.png"
hcraft_entity.braking_power = "1200kW"
hcraft_entity.consumption = "250kW"
hcraft_entity.effectivity = 1.3
hcraft_entity.max_health = 500
hcraft_entity.guns = {}
hcraft_entity.terrain_friction_modifier = 0
hcraft_entity.rotation_speed = 0.0060
hcraft_entity.tank_driving = true
hcraft_entity.weight = 2500
hcraft_entity.minable = {mining_time = 0.5, result = "hcraft-item"}
hcraft_entity.has_belt_immunity = true
hcraft_entity.collision_mask = {"player-layer","train-layer"}
hcraft_entity.stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.0
          }
        }
      }
    }
hcraft_entity.animation = { --animation required for car type
        layers = {
          {
            animation_speed = 8,
            direction_count = 64,
            frame_count = 1,
            height = 90,
			width = 119,
            max_advance = 0.2,
            priority = "low",
            shift = {0,0},
            stripes = {
              {
                filename = "__Hovercrafts__/graphics/hovercraft1-sd.png",
                height_in_frames = 11,
                width_in_frames = 1
              },
              {
                filename = "__Hovercrafts__/graphics/hovercraft2-sd.png",
                height_in_frames = 11,
                width_in_frames = 1
              },
              {
                filename = "__Hovercrafts__/graphics/hovercraft3-sd.png",
                height_in_frames = 11,
                width_in_frames = 1
              },
			  {
                filename = "__Hovercrafts__/graphics/hovercraft4-sd.png",
                height_in_frames = 10,
                width_in_frames = 1
              },
              {
                filename = "__Hovercrafts__/graphics/hovercraft5-sd.png",
                height_in_frames = 11,
                width_in_frames = 1
              },
              {
                filename = "__Hovercrafts__/graphics/hovercraft6-sd.png",
                height_in_frames = 10,
                width_in_frames = 1
              }
            },
			hr_version = {
				animation_speed = 8,
				direction_count = 64,
				frame_count = 1,
				height = 180,
				width = 237,
				scale = 0.5,
				max_advance = 0.2,
				priority = "low",
				shift = {0,0},
				stripes = {
				  {
					filename = "__Hovercrafts__/graphics/hovercraft1.png",
					height_in_frames = 11,
					width_in_frames = 1
				  },
				  {
					filename = "__Hovercrafts__/graphics/hovercraft2.png",
					height_in_frames = 11,
					width_in_frames = 1
				  },
				  {
					filename = "__Hovercrafts__/graphics/hovercraft3.png",
					height_in_frames = 11,
					width_in_frames = 1
				  },
				  {
					filename = "__Hovercrafts__/graphics/hovercraft4.png",
					height_in_frames = 10,
					width_in_frames = 1
				  },
				  {
					filename = "__Hovercrafts__/graphics/hovercraft5.png",
					height_in_frames = 11,
					width_in_frames = 1
				  },
				  {
					filename = "__Hovercrafts__/graphics/hovercraft6.png",
					height_in_frames = 10,
					width_in_frames = 1
				  }
				},
			},
		  },
		  {
            animation_speed = 8,
            direction_count = 64,
            frame_count = 1,
            height = 90,
			width = 119,
            max_advance = 0.2,
            priority = "low",
            shift = {.3,.3},
			draw_as_shadow = true,
            stripes = {
			  {
					filename = "__Hovercrafts__/graphics/shadow-combined-sd-1.png",
					height_in_frames = 20,
					width_in_frames = 1
			  },{
					filename = "__Hovercrafts__/graphics/shadow-combined-sd-2.png",
					height_in_frames = 20,
					width_in_frames = 1
			  },{
					filename = "__Hovercrafts__/graphics/shadow-combined-sd-3.png",
					height_in_frames = 20,
					width_in_frames = 1
			  },{
					filename = "__Hovercrafts__/graphics/shadow-combined-sd-4.png",
					height_in_frames = 4,
					width_in_frames = 1
			  },
            },
		  }
        }
      }
hcraft_entity.turret_animation = {
		layers = {
          {
            animation_speed = 8,
            direction_count = 1,
            frame_count = 1,
            height = 1,
			width = 1,
            max_advance = 0.2,
            priority = "low",
            shift = {0,0},
            stripes = {
				{
					filename = "__core__/graphics/empty.png",
					height_in_frames = 1,
					width_in_frames = 1
				}
			}
		  }
		}
	}


-- Item
hcraft_item.name = "hcraft-item"
hcraft_item.icon = "__Hovercrafts__/graphics/icons/hcraft_small.png"
hcraft_item.subgroup = subgroup_hc
hcraft_item.order = "b[personal-transport]-c[hcraft-item]"
hcraft_item.place_result = "hcraft-entity"	


-- Tech
hcraft_tech.name = "hcraft-tech"
hcraft_tech.icon = "__Hovercrafts__/graphics/icons/hcraft_large.png"
hcraft_tech.effects =
	{
		{type = "unlock-recipe", recipe = "hcraft-recipe"},
	}
hcraft_tech.prerequisites = {"automobilism", "effectivity-module", "speed-module", "chemical-science-pack"}
hcraft_tech.unit =
	{
		count = 100,
		ingredients =
		{
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
		},
		time = 30
	}


-- Recipe
hcraft_recipe.name = "hcraft-recipe"
hcraft_recipe.energy_required = 4
hcraft_recipe.ingredients =
	{
		{"iron-gear-wheel", 20},
		{"steel-plate", 10},
        {"engine-unit", 10},
        {"speed-module", 2},
        {"effectivity-module", 2}
    }
hcraft_recipe.result = "hcraft-item"

-- Hover smoke
hover_smoke.name = "hover-smoke"
hover_smoke.render_layer = "building-smoke"
hover_smoke.affected_by_wind = false
hover_smoke.duration = 35
hover_smoke.start_scale = 1
hover_smoke.end_scale = 1.4
hover_smoke.fade_away_duration = 30
hover_smoke.fade_in_duration = 5
hover_smoke.spread_duration = 30
hover_smoke.animation.shift = {0,0}

data:extend({
	hcraft_entity,
	hcraft_item,
	hcraft_tech,
	hcraft_recipe,
	hover_smoke
})