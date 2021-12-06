local hcraft_remnants = table.deepcopy(data.raw.corpse["car-remnants"])
hcraft_remnants.name = "hovercraft-remnants"
hcraft_remnants.animation.layers[1].filename = HCGRAPHICS .. "entity/hovercraft/remnants/hovercraft-remnants.png"
hcraft_remnants.animation.layers[1].hr_version.filename = HCGRAPHICS .. "entity/hovercraft/remnants/hr-hovercraft-remnants.png"
data:extend({hcraft_remnants})

-- collision box
local collision = table.deepcopy(data.raw.car.car)
  collision.name = "hovercraft-collision"
  collision.order = "hovercraft-collision"
  collision.collision_box[1][1] = collision.collision_box[1][1]*1.2
  collision.collision_box[1][2] = collision.collision_box[1][2]*1.2
  collision.collision_box[2][1] = collision.collision_box[2][1]*1.2
  collision.collision_box[2][2] = collision.collision_box[2][2]*1.2
data:extend({collision})

--------------------------------------------------------------------------------------------------------------------
local hcraft_entity = table.deepcopy(data.raw.car.car)
hcraft_entity.name = "hcraft-entity"
hcraft_entity.icon = HCGRAPHICS .. "icons/hovercraft_icon.png"
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
  { type = "fire",      decrease = 7.5, percent = 30 },
  { type = "physical",  decrease = 7.5, percent = 30 },
  { type = "impact",    decrease = 40,  percent = 65 },
  { type = "explosion", decrease = 7.5, percent = 35 },
  { type = "acid",      decrease = 0,   percent = 35 }
}
hcraft_entity.stop_trigger = {
  { type = "play-sound", sound = { { filename = "__base__/sound/car-breaks.ogg", volume = 0.0 } } }
}
hcraft_entity.animation = {
  layers = {
    {
      filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-base.png",
      priority = "high",
      line_length = 8,
      size = 128,
      max_advance = 0.2,
      direction_count = 64,
      scale = 1,
      hr_version = {
        filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-base.png",
        priority = "high",
        line_length = 8,
        size = 256,
        max_advance = 0.2,
        direction_count = 64,
        scale = 0.5,
      }
    },
    {
      filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-mask.png",
      priority = "low",
      line_length = 8,
      size = 128,
      max_advance = 0.2,
      direction_count = 64,
      scale = 1,
      apply_runtime_tint = true,
      hr_version = {
        filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-mask.png",
        priority = "low",
        line_length = 8,
        size = 256,
        max_advance = 0.2,
        direction_count = 64,
        scale = 0.5,
        apply_runtime_tint = true,
      }
    },
    {
      filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-shadow.png",
      line_length = 8,
      size = 128,
      max_advance = 0.2,
      direction_count = 64,
      shift = util.by_pixel(4, 4),
      draw_as_shadow = true,
      hr_version = {
        filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-shadow.png",
        line_length = 8,
        size = 256,
        max_advance = 0.2,
        direction_count = 64,
        scale = 0.5,
        shift = util.by_pixel(4, 4),
        draw_as_shadow = true,
      }
    },
  }
}
hcraft_entity.light_animation = {
  filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-light.png",
  priority = "low",
  blend_mode = "additive",
  draw_as_glow = true,
  size = 128,
  line_length = 8,
  direction_count = 64,
  hr_version =
  {
    filename = HCGRAPHICS .. "entity/hovercraft/hr-hovercraft-light.png",
    priority = "low",
    blend_mode = "additive",
    draw_as_glow = true,
    size = 256,
    line_length = 8,
    direction_count = 64,
    scale = 0.5,
  }
}
hcraft_entity.water_reflection = {
  pictures = {
    filename = HCGRAPHICS .. "entity/hovercraft/hovercraft-water-reflection.png",
    width = 26,
    height = 26,
    shift = util.by_pixel(0, 15),
    variation_count = 1,
    scale = 5
  },
  rotate = true,
  orientation_to_variation = false
}
hcraft_entity.turret_animation = nil
data:extend({hcraft_entity})

--------------------------------------------------------------------------------------------------------------------
if mcraft_activated then
  -- Mcraft entity
  local mcraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
  mcraft_entity.name = "mcraft-entity"
  mcraft_entity.icon = HCGRAPHICS .. "icons/hovercraft_mcraft_icon.png"
  mcraft_entity.icon_size = 64
  mcraft_entity.braking_power = "1500kW"
  mcraft_entity.consumption = "450kW"
  mcraft_entity.effectivity = 1.1
  mcraft_entity.max_health = 1200
  mcraft_entity.rotation_speed = 0.0045
  mcraft_entity.tank_driving = true
  mcraft_entity.immune_to_tree_impacts = true
  mcraft_entity.immune_to_rock_impacts = true
  mcraft_entity.weight = 10000
  mcraft_entity.minable = {mining_time = 0.5, result = "mcraft-entity"}
  mcraft_entity.resistances = {
    { type = "fire",      decrease = 10, percent = 55 },
    { type = "physical",  decrease = 10, percent = 55 },
    { type = "impact",    decrease = 30, percent = 65 },
    { type = "explosion", decrease = 10, percent = 65 },
    { type = "acid",      decrease = 0,  percent = 55 }
  }
  mcraft_entity.burner = {
    fuel_category = "chemical",
    effectivity = 1,
    fuel_inventory_size = 2,
  }
  mcraft_entity.guns = {"hovercraft-missile-turret"}
  mcraft_entity.turret_animation = {
    layers = {
      {
        filename = HCGRAPHICS .. "entity/turret/hovercraft-missile-turret.png",
        line_length = 8,
        size = 64,
        direction_count = 64,
        shift = util.by_pixel(0, -27),
        hr_version = {
          filename = HCGRAPHICS .. "entity/turret/hr-hovercraft-missile-turret.png",
          line_length = 8,
          size = 128,
          direction_count = 64,
          shift = util.by_pixel(0, -27),
          scale = 0.5,
        }
      },
      {
        filename = HCGRAPHICS .. "entity/turret/hovercraft-missile-turret-shadow.png",
        line_length = 8,
        size = 64,
        direction_count = 64,
        shift = util.by_pixel(40, 17),
        draw_as_shadow = true,
        hr_version = {
          filename = HCGRAPHICS .. "entity/turret/hr-hovercraft-missile-turret-shadow.png",
          line_length = 8,
          size = 128,
          direction_count = 64,
          shift = util.by_pixel(40, 17),
          draw_as_shadow = true,
          scale = 0.5,
        }
      },
    }
  }
  mcraft_entity.turret_rotation_speed = 0.40 / 60
  mcraft_entity.turret_return_timeout = 300

  local mcraft_gun = table.deepcopy(data.raw.gun["vehicle-machine-gun"])
  mcraft_gun.name = "hovercraft-missile-turret"
  mcraft_gun.icon = HCGRAPHICS .. "icons/hovercraft-missile-turret-icon.png"
  mcraft_gun.icon_size = 64
  mcraft_gun.icon_mipmaps = 0
  mcraft_gun.order = "d[rocket-launcher]"
  mcraft_gun.attack_parameters = {
    type = "projectile",
    ammo_category = "rocket",
    cooldown = 120, --60, --300,
    movement_slow_down_factor = 0.9,
    projectile_center = {-0.17, 0},
    projectile_creation_distance = 0.6,
    range = 36,
    sound = {
      {
        filename = "__base__/sound/fight/rocket-launcher.ogg",
        volume = 0.7
      }
    }
  }
  data:extend({mcraft_entity, mcraft_gun})
end

--------------------------------------------------------------------------------------------------------------------
if ecraft_activated then
  local ecraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
  ecraft_entity.name = "ecraft-entity"
  ecraft_entity.icon = HCGRAPHICS .. "icons/hovercraft_ecraft_icon.png"
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
  data:extend({ecraft_entity})
end

--------------------------------------------------------------------------------------------------------------------
if lcraft_activated then
  local lcraft_entity = table.deepcopy(data.raw.car["hcraft-entity"])
  lcraft_entity.name = "lcraft-entity"
  lcraft_entity.icon = HCGRAPHICS .. "icons/hovercraft_lcraft_icon.png"
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
    { type = "fire", decrease = 7.5, percent = 30 },
    { type = "physical", decrease = 7.5, percent = 30 },
    { type = "impact", decrease = 40, percent = 75 },
    { type = "explosion", decrease = 7.5, percent = 35 },
    { type = "acid", decrease = 0, percent = 35 }
  }
  lcraft_entity.guns = {"vehicle-laser-gun"}
  lcraft_entity.turret_rotation_speed = 0.35 / 60
  lcraft_entity.turret_animation = data.raw.car.car.turret_animation
  data:extend({lcraft_entity})
end