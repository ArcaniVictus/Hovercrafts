local hcraft_item = table.deepcopy(data.raw["item-with-entity-data"].car)
hcraft_item.name = "hcraft-entity"
hcraft_item.icon = HCGRAPHICS .. "icons/hcraft_small.png"
hcraft_item.icon_size = 64
hcraft_item.icon_mipmaps = 0
hcraft_item.subgroup = subgroup_hovercrafts
hcraft_item.order = "b[personal-transport]-c[hcraft-item]"
hcraft_item.place_result = "hcraft-entity"
data:extend({hcraft_item})

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

--------------------------------------------------------------------------------------------------------------------

if settings.startup["enable-mcraft"].value then
  local mcraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
  mcraft_item.name = "mcraft-entity"
  mcraft_item.icon = HCGRAPHICS .. "icons/mcraft_small.png"
  mcraft_item.icon_size = 64
  mcraft_item.icon_mipmaps = 0
  mcraft_item.order = "b[personal-transport]-d[mcraft-entity]"
  mcraft_item.place_result = "mcraft-entity"

  local mcraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])
  mcraft_recipe.name = "mcraft-recipe"
  mcraft_recipe.ingredients = {
    {"hcraft-entity", 1},
    {"advanced-circuit", 40},
    {"gun-turret", 2},
    {"rocket-launcher", 16}
  }
  mcraft_recipe.result = "mcraft-entity"

  if mods["vtk-armor-plating"] then
    table.insert(mcraft_recipe.ingredients, {"vtk-armor-plating", 12})
  end
  data:extend({mcraft_item, mcraft_recipe})
end

if ecraft_activated then
  local ecraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
  ecraft_item.name = "ecraft-entity"
  ecraft_item.icon = HCGRAPHICS .. "icons/ecraft_small.png"
  ecraft_item.icon_size = 64
  ecraft_item.icon_mipmaps = 0
  ecraft_item.order = "b[personal-transport]-e[ecraft-item]"
  ecraft_item.place_result = "ecraft-entity"
  data:extend({ecraft_item})

  local ecraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])
  ecraft_recipe.name = "ecraft-recipe"
  ecraft_recipe.ingredients = {
    {"low-density-structure", 25},
    {"electric-engine-unit", 40},
    {"processing-unit", 20},
    {"hcraft-entity", 1},
  }
  ecraft_recipe.result = "ecraft-entity"
  data:extend({ecraft_recipe})
end

if lcraft_activated then
  local lcraft_item = table.deepcopy(data.raw["item-with-entity-data"]["hcraft-entity"])
  lcraft_item.name = "lcraft-entity"
  lcraft_item.icon = HCGRAPHICS .. "icons/lcraft_small_elec.png"
  lcraft_item.icon_size = 64
  lcraft_item.icon_mipmaps = 0
  lcraft_item.subgroup = subgroup_hovercrafts
  lcraft_item.order = "d[personal-transport]-d"
  lcraft_item.place_result = "lcraft-entity"
  data:extend({lcraft_item})

  local lcraft_recipe = table.deepcopy(data.raw.recipe["hcraft-recipe"])
  lcraft_recipe.name = "lcraft-recipe"
  lcraft_recipe.ingredients = {
    {"ecraft-entity", 1},
    {"laser-turret", 2},
    {"heat-pipe", 25},
    {"heat-exchanger", 2},
  }
  lcraft_recipe.result = "lcraft-entity"
  data:extend({

    lcraft_recipe,

    {
      type = "item",
      name = "lcraft-charger",
      icon = HCGRAPHICS .. "icons/lcraft_charger-icon.png",
      icon_size = 64,
      flags = {},
      placed_as_equipment_result = "lcraft-charger",
      subgroup = "equipment",
      order = "e[robotics]-a[personal-roboport-equipment]",
      stack_size = 20
    },
    {
      type = "recipe",
      name = "lcraft-charger",
      enabled = false,
      energy_required = 10,
      ingredients = {
        {"processing-unit", 25},
        {"energy-shield-mk2-equipment", 5},
        {"ehvt-equipment", 2}
      },
      result = "lcraft-charger"
    },
  })
end

if electriccraft_equipment_activated then
  local ehvt_item = table.deepcopy(data.raw.item["battery"])
  ehvt_item.name = "ehvt-equipment"
  ehvt_item.icon = HCGRAPHICS .. "icons/ehvt-item.png"
  ehvt_item.icon_size = 64
  ehvt_item.icon_mipmaps = 0
  ehvt_item.placed_as_equipment_result = "ehvt-equipment"
  ehvt_item.subgroup = subgroup_hovercrafts_ehvt
  ehvt_item.order = "d2"
  ehvt_item.stack_size = 10
  data:extend({ehvt_item})

  local ehvt_recipe = table.deepcopy(data.raw.recipe["battery-equipment"])
  ehvt_recipe.name = "ehvt-equipment"
  ehvt_recipe.category = "crafting-with-fluid"
  ehvt_recipe.ingredients = {
    {"battery-mk2-equipment", 2},
    {"processing-unit", 5},
    {type = "fluid", name = "lubricant", amount = 50},
  }
  ehvt_recipe.result = "ehvt-equipment"
  data:extend({ehvt_recipe})
end
