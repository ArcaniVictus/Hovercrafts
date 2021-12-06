local function unlock(recipe)
  return {
    type = "unlock-recipe",
    recipe = recipe
  }
end

data:extend({
  {
    type = "technology",
    name = "hcraft-tech",
    icon = HCGRAPHICS .. "technology/hcraft_tech.png",
    icon_size = 256,
    effects = {
      unlock("hcraft-recipe")
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

if mcraft_activated then
  data:extend({
    {
      type = "technology",
      name = "mcraft-tech",
      icon = HCGRAPHICS .. "technology/mcraft_tech.png",
      icon_size = 256,
      effects = {
        unlock("mcraft-recipe")
      },
      prerequisites = {"hcraft-tech", "gun-turret", "rocketry"},
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

if ecraft_activated then
  data:extend({
    {
      type = "technology",
      name = "ecraft-tech",
      icon = HCGRAPHICS .. "technology/ecraft_tech.png",
      icon_size = 256,
      effects = {
        unlock("ecraft-recipe"),
        unlock("ehvt-equipment"),
      },
      prerequisites = {"hcraft-tech"},
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

if lcraft_activated then
  data:extend({
    {
      type = "technology",
      name = "lcraft-tech",
      icon = HCGRAPHICS .. "technology/lcraft_tech.png",
      icon_size = 256,
      effects = {
        unlock("lcraft-recipe"),
        unlock("lcraft-charger"),
      },
      prerequisites = {"laser-turret", "laser-rifle-2", "nuclear-power", "ecraft-tech"},
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