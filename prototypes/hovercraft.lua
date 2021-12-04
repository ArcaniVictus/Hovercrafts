-- hovercraft
-- prototypes.hovercraft


-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"

if mods["SchallTransportGroup"] then
	subgroup_hc = "hovercrafts"
end


-- Hovercraft
local hovercraft_entity = table.deepcopy(data.raw["car"]["car"])
local updates = {
	name = "hovercraft-entity",
	icon = "__Hovercrafts__/graphics/icons/hovercraft_small.png",
	icon_size = 32,
	braking_power = "1200kW",
	consumption = "250kW",
	effectivity = 1.3,
	max_health = 500,
	guns = {},
	terrain_friction_modifier = 0,
	rotation_speed = 0.0060,
    tank_driving = true,
	weight = 2500,
	minable = {mining_time = 0.5, result = "hovercraft-item"},
	has_belt_immunity = true,
	collision_mask = {"player-layer","train-layer"},
	stop_trigger =
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
    },

	animation = { --animation required for car type
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
			---[[
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
			}, --]]
            
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
      },
	turret_animation = {
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
}
for k,v in pairs(updates) do
	hovercraft_entity[k] = updates[k]
end

-- smoke
local hover_smoke = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
local updates = {
	affected_by_wind = false,
	duration = 35,
	start_scale = 1,
	end_scale = 1.4,
	fade_away_duration = 30,
	fade_in_duration = 5,
	name = "hover-smoke",
	spread_duration = 30,
	render_layer = "building-smoke",
}
for k,v in pairs(updates) do
	hover_smoke[k] = updates[k]
end
hover_smoke.animation.shift = {0,0}


--[[ Subgroup
local newSubgroup = {
      group = "logistics",
      name = "transport2",
      order = "e-a",
      type = "item-subgroup"
}
data.raw["item-with-entity-data"]["car"].subgroup = "transport2"
data.raw["item-with-entity-data"]["tank"].subgroup = "transport2"
]]--

-- Item
local hovercraft_item = {
	type = "item-with-entity-data",
	name = "hovercraft-item",
	icon = "__Hovercrafts__/graphics/icons/hovercraft_small.png",
	icon_size = 32,
	subgroup = subgroup_hc, --"transport2",
	order = "b[personal-transport]-c[hovercraft-item]",
	stack_size = 1,
	place_result = "hovercraft-entity"	
}


-- Tech
local hovercraft_tech = {
	type = "technology",
	name = "hovercraft-tech",
	icon = "__Hovercrafts__/graphics/icons/hovercraft_large.png", -- change
	icon_size = 128,
	effects =
	{
		{type = "unlock-recipe", recipe = "hovercraft-recipe"},
	},
	prerequisites = {"automobilism", "effectivity-module", "speed-module", "chemical-science-pack"},
	unit =
	{
		count = 100,
		ingredients =
		{
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
		},
		time = 30
	},
	order = "a"
}


-- Recipe
local hovercraft_recipe = {
	type = "recipe",
	name = "hovercraft-recipe",
	energy_required = 10,
	enabled = false,
	ingredients =
	{
		{"iron-gear-wheel", 20},
		{"steel-plate", 10},
        {"engine-unit", 10},
        {"speed-module", 2},
        {"effectivity-module", 2}
    },
	result = "hovercraft-item",
	result_count = 1
}

data:extend({
	hovercraft_tech,
	hovercraft_recipe,
	hovercraft_item,
	hovercraft_entity,
	hover_smoke,
	newSubgroup
})