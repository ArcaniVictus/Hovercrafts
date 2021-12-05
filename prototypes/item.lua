-- Item
local hcraft_item = table.deepcopy(data.raw["item-with-entity-data"].car)
hcraft_item.name = "hcraft-entity"
hcraft_item.icon = HCGRAPHICS .. "icons/hcraft_small.png"
hcraft_item.icon_size = 64
hcraft_item.icon_mipmaps = 0
hcraft_item.subgroup = subgroup_hovercrafts
hcraft_item.order = "b[personal-transport]-c[hcraft-item]"
hcraft_item.place_result = "hcraft-entity"
data:extend({hcraft_item})

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
data:extend({hcraft_recipe})


-- Mcraft item
local mcraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
mcraft_item.name = "mcraft-entity"
mcraft_item.icon = HCGRAPHICS .. "icons/mcraft_small.png"
mcraft_item.icon_size = 64
mcraft_item.icon_mipmaps = 0
mcraft_item.order = "b[personal-transport]-d[mcraft-entity]"
mcraft_item.place_result = "mcraft-entity"

-- Mcraft recipe
local mcraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])
mcraft_recipe.name = "mcraft-recipe"
mcraft_recipe.ingredients = {
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

if settings.startup["enable-mcraft"].value then
  data:extend({mcraft_item, mcraft_recipe})
end
