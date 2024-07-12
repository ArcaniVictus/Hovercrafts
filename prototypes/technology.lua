local function unlock(recipe)
  return {
    type = "unlock-recipe",
    recipe = recipe
  }
end

data:extend({
  {
    type = "technology",
    name = "hovercraft",
    icon = HCGRAPHICS .. "technology/hcraft_tech.png",
    icon_size = 256, icon_mipmaps = 1,
    effects = {
      unlock("hovercraft")
    },
    prerequisites = {"automobilism", "effectivity-module", "speed-module", "chemical-science-pack"},
    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "z"
  },
})

if missile_hovercraft_activated then
  data:extend({
    {
      type = "technology",
      name = "missile-hovercraft",
      icon = HCGRAPHICS .. "technology/mcraft_tech.png",
      icon_size = 256, icon_mipmaps = 1,
      effects = {
        unlock("missile-hovercraft")
      },
      prerequisites = {"hovercraft", "gun-turret", "rocketry"},
      unit = {
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
      order = "z"
    },
  })
end

if electric_hovercraft_activated then
  data:extend({
    {
      type = "technology",
      name = "electric-hovercraft",
      icon = HCGRAPHICS .. "technology/ecraft_tech.png",
      icon_size = 256, icon_mipmaps = 1,
      effects = {
        unlock("electric-hovercraft"),
        unlock("ehvt-equipment"),
      },
      prerequisites = {"hovercraft"},
      unit = {
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
      order = "z"
    },
  })
end

if laser_hovercraft_activated then
  data:extend({
    {
      type = "technology",
      name = "laser-hovercraft",
      icon = HCGRAPHICS .. "technology/lcraft_tech.png",
      icon_size = 256, icon_mipmaps = 1,
      effects = {
        unlock("laser-hovercraft"),
        unlock("lcraft-charger"),
      },
      prerequisites = {"laser-turret", "laser-rifle-2", "nuclear-power", "electric-hovercraft"},
      unit = {
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
      order = "z"
    },
  })
end