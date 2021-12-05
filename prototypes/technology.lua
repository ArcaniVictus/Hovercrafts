
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
data:extend({hcraft_tech})

if settings.startup["enable-mcraft"].value then



-- Mcraft tech
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

data:extend({
  mcraft_tech,
})
end