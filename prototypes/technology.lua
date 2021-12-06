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
data:extend({hcraft_tech})

--------------------------------------------------------------------------------------------------------------------

if mcraft_activated then
  local mcraft_tech = table.deepcopy(data.raw.technology["hcraft-tech"])
  mcraft_tech.name = "mcraft-tech"
  mcraft_tech.icon = HCGRAPHICS .. "technology/mcraft_large.png"
  mcraft_tech.icon_size = 256
  mcraft_tech.effects = {
    {type = "unlock-recipe", recipe = "mcraft-recipe"},
  }
  mcraft_tech.prerequisites = {"hcraft-tech", "gun-turret", "rocketry"}
  mcraft_tech.unit = {
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
  data:extend({mcraft_tech})
end

if ecraft_activated then
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
  data:extend({ecraft_tech})
end

if lcraft_activated then
  local lcraft_tech = table.deepcopy(data.raw.technology["hcraft-tech"])
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
  data:extend({lcraft_tech})
end
