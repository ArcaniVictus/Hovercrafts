-- prototypes.hcraft.lua

-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_hc = "transport2"

if mods["SchallTransportGroup"] or mods["trainConstructionSite"] then
  subgroup_hc = "hovercrafts"
end

-- Hovercraft entity
local hcraft_entity = table.deepcopy(data.raw.car.car)
hcraft_entity.name = "hcraft-entity"
hcraft_entity.icon = HCGRAPHICS .. "icons/hcraft_small.png"
hcraft_entity.icon_size = 64
hcraft_entity.corpse = "hovercraft-remnants"
hcraft_entity.braking_power = "1200kW"
hcraft_entity.consumption = "250kW"
hcraft_entity.effectivity = 1.3
hcraft_entity.max_health = 500
hcraft_entity.guns = {}
hcraft_entity.terrain_friction_modifier = 0
hcraft_entity.rotation_speed = 0.0060
hcraft_entity.tank_driving = true
hcraft_entity.weight = 2500
hcraft_entity.minable = {mining_time = 0.5, result = "hcraft-entity"}
hcraft_entity.has_belt_immunity = true
hcraft_entity.collision_mask = { "train-layer", "layer-14" } --{, "not-colliding-with-itself"}
hcraft_entity.resistances = {
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
    percent = 65
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
hcraft_entity.stop_trigger = {
  {
    type = "play-sound",
    sound = {
      {
        filename = "__base__/sound/car-breaks.ogg",
        volume = 0.0
      }
    }
  }
}
hcraft_entity.light_animation = {
  filename = "__base__/graphics/entity/car/car-light.png",
  priority = "low",
  blend_mode = "additive",
  draw_as_glow = true,
  width = 102,
  height = 84,
  line_length = 8,
  direction_count = 64,
  shift = util.by_pixel(0 + 2, -8 + 3),
  repeat_count = 1,
  hr_version =
  {
    filename = "__base__/graphics/entity/car/hr-car-light.png",
    priority = "low",
    blend_mode = "additive",
    draw_as_glow = true,
    width = 206,
    height = 162,
    line_length = 8,
    direction_count = 64,
    scale = 0.5,
    shift = util.by_pixel(-1 + 2, -6 + 3),
    repeat_count = 1,
  }
}
hcraft_entity.animation = { --animation required for car type
  layers = {
    {
      priority = "low",
      width = 119,
      height = 90,
      frame_count = 1,
      direction_count = 64,
      shift = {0,0},
      animation_speed = 8,
      max_advance = 0.2,
      stripes =
      {
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-1.png",
          width_in_frames = 1,
          height_in_frames = 11
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-2.png",
          width_in_frames = 1,
          height_in_frames = 11
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-3.png",
          width_in_frames = 1,
          height_in_frames = 11
        },
       {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-4.png",
          width_in_frames = 1,
          height_in_frames = 10
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-5.png",
          width_in_frames = 1,
          height_in_frames = 11
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-6.png",
          width_in_frames = 1,
          height_in_frames = 10
        }
      },
      hr_version = {
        priority = "low",
        width = 237,
        height = 180,
        frame_count = 1,
        scale = 0.5,
        direction_count = 64,
        shift = {0,0},
        animation_speed = 8,
        max_advance = 0.2,
        --line_length = 2,
        stripes =
        {
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-1.png",
            width_in_frames = 1,
            height_in_frames = 11
          },
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-2.png",
            width_in_frames = 1,
            height_in_frames = 11
          },
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-3.png",
            width_in_frames = 1,
            height_in_frames = 11
          },
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-4.png",
            width_in_frames = 1,
            height_in_frames = 10
          },
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-5.png",
            width_in_frames = 1,
            height_in_frames = 11
          },
          {
            filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-6.png",
            width_in_frames = 1,
            height_in_frames = 10
          }
        },
      },
    },
    {
      priority = "low",
      width = 119,
      height = 90,
      frame_count = 1,
      draw_as_shadow = true,
      direction_count = 64,
      shift = {.3,.3},
      max_advance = 0.2,
      --animation_speed = 8,
      stripes = {
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-shadow-1.png",
          height_in_frames = 20,
          width_in_frames = 1
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-shadow-2.png",
          height_in_frames = 20,
          width_in_frames = 1
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-shadow-3.png",
          height_in_frames = 20,
          width_in_frames = 1
        },
        {
          filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-shadow-4.png",
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
      width = 1,
      height = 1,
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
local hcraft_item = table.deepcopy(data.raw["item-with-entity-data"].car)
hcraft_item.name = "hcraft-entity"
hcraft_item.icon = HCGRAPHICS .. "icons/hcraft_small.png"
hcraft_item.icon_size = 64
hcraft_item.icon_mipmaps = 0
hcraft_item.subgroup = subgroup_hc
hcraft_item.order = "b[personal-transport]-c[hcraft-item]"
hcraft_item.place_result = "hcraft-entity"

-- Tech
local hcraft_tech = table.deepcopy(data.raw.technology.automobilism)
hcraft_tech.name = "hcraft-tech"
hcraft_tech.icon = HCGRAPHICS .. "technology/hcraft_large.png"
hcraft_tech.icon_size = 256
hcraft_tech.effects = {
  {type = "unlock-recipe", recipe = "hcraft-recipe"},
}
hcraft_tech.prerequisites = {"automobilism", "effectivity-module", "speed-module", "chemical-science-pack"}
hcraft_tech.unit = {
  count = 100,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
  },
  time = 30
}

-- Recipe
local hcraft_recipe = table.deepcopy(data.raw.recipe.car)
hcraft_recipe.name = "hcraft-recipe"
hcraft_recipe.energy_required = 4
hcraft_recipe.ingredients = {
  {"iron-gear-wheel", 20},
  {"steel-plate", 10},
  {"engine-unit", 10},
  {"speed-module", 2},
  {"effectivity-module", 2}
}
hcraft_recipe.result = "hcraft-entity"

-- Hover smoke
local hover_smoke = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
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