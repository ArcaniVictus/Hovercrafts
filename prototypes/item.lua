data:extend({
  {
    type = "item-with-entity-data",
    name = "hcraft-entity",
    icon = HCGRAPHICS .. "icons/hovercraft_icon.png",
    icon_size = 64,
    subgroup = subgroup_hovercrafts,
    order = "b[personal-transport]-c[hcraft-item]",
    place_result = "hcraft-entity",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "hcraft-recipe",
    enabled = false,
    energy_required = 4,
    ingredients = {
      {"iron-gear-wheel", 20},
      {"steel-plate", 10},
      {"engine-unit", 10},
      {"speed-module", 2},
      {"effectivity-module", 2}
    },
    result = "hcraft-entity"
  },
})

--------------------------------------------------------------------------------------------------------------------
if mcraft_activated then
  data:extend({
    {
      type = "item-with-entity-data",
      name = "mcraft-entity",
      icon = HCGRAPHICS .. "icons/hovercraft_mcraft_icon.png",
      icon_size = 64,
      subgroup = subgroup_hovercrafts,
      order = "b[personal-transport]-d[mcraft-entity]",
      place_result = "mcraft-entity",
      stack_size = 1
    },
    {
      type = "recipe",
      name = "mcraft-recipe",
      enabled = false,
      energy_required = 4,
      ingredients = {
        {"hcraft-entity", 1},
        {"advanced-circuit", 40},
        {"gun-turret", 2},
        {"rocket-launcher", 16}
      },
      result = "mcraft-entity"
    },
  })

  if mods["vtk-armor-plating"] then
    table.insert(data.raw.recipe["mcraft-recipe"].ingredients, {"vtk-armor-plating", 12})
  end
end

--------------------------------------------------------------------------------------------------------------------
if ecraft_activated then
  data:extend({
    {
      type = "item-with-entity-data",
      name = "ecraft-entity",
      icon = HCGRAPHICS .. "icons/hovercraft_ecraft_icon.png",
      icon_size = 64,
      subgroup = subgroup_hovercrafts,
      order = "b[personal-transport]-e[ecraft-item]",
      place_result = "ecraft-entity",
      stack_size = 1
    },
    {
      type = "recipe",
      name = "ecraft-recipe",
      enabled = false,
      energy_required = 4,
      ingredients = {
        {"low-density-structure", 25},
        {"electric-engine-unit", 40},
        {"processing-unit", 20},
        {"hcraft-entity", 1},
      },
      result = "ecraft-entity"
    },
  })
end

--------------------------------------------------------------------------------------------------------------------
if lcraft_activated then
  data:extend({
    {
      type = "item-with-entity-data",
      name = "lcraft-entity",
      icon = HCGRAPHICS .. "icons/hovercraft_lcraft_icon.png",
      icon_size = 64,
      subgroup = subgroup_hovercrafts,
      order = "d[personal-transport]-d",
      place_result = "lcraft-entity",
      stack_size = 1
    },
    {
      type = "recipe",
      name = "lcraft-recipe",
      enabled = false,
      energy_required = 4,
      ingredients = {
        {"ecraft-entity", 1},
        {"laser-turret", 2},
        {"heat-pipe", 25},
        {"heat-exchanger", 2},
      },
      result = "lcraft-entity"
    },
    {
      type = "item",
      name = "lcraft-charger",
      icon = HCGRAPHICS .. "icons/equipment_lcraft_charger_icon.png",
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

  if mods["SchallTransportGroup"] then
    data.raw["item"]["lcraft-charger"].subgroup = "vehicle-equipment"
    data.raw["item"]["lcraft-charger"].order = "e2"
  end
end

--------------------------------------------------------------------------------------------------------------------
if electriccraft_equipment_activated then
  data:extend({
    {
      type = "item",
      name = "ehvt-equipment",
      icon = HCGRAPHICS .. "icons/equipment_ehvt_icon.png",
      icon_size = 64,
      subgroup = subgroup_hovercrafts_ehvt,
      order = "d2",
      placed_as_equipment_result = "ehvt-equipment",
      stack_size = 10
    },
    {
      type = "recipe",
      name = "ehvt-equipment",
      enabled = false,
      category = "crafting-with-fluid",
      energy_required = 10,
      ingredients = {
        {"battery-mk2-equipment", 2},
        {"processing-unit", 5},
        {type = "fluid", name = "lubricant", amount = 50},
      },
      result = "ehvt-equipment"
    },
  })
end
