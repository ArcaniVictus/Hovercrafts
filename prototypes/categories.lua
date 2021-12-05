-- prototypes.categories.lua

-- Support for  Schallfalke's Schall Transport Group mod
subgroup_hovercrafts = "transport2"
subgroup_hovercrafts_ehvt = "electric-vehicles-equipment"

if mods["trainConstructionSite"] then
  data:extend({
    {
      type = "item-subgroup",
      name = "hovercrafts",
      group = "transport-logistics",
      order = "c2"
    }
  })
  subgroup_hovercrafts = "hovercrafts"
end

if mods["SchallTransportGroup"] then
  data:extend({
    {
      type = "item-subgroup",
      name = "hovercrafts",
      group = "transport",
      order = "c-2"
    }
  })
  subgroup_hovercrafts = "hovercrafts"
  subgroup_hovercrafts_ehvt = "vehicle-equipment"
else
  data.raw["item-with-entity-data"].car.subgroup = "transport2"
  data.raw["item-with-entity-data"].tank.subgroup = "transport2"
end

data:extend({
  {
    type = "equipment-category",
    name = "electric-hovercraft-equipment",
  },
  {
    type = "equipment-category",
    name = "lcraft-charger",
  },
  {
    type = "item-subgroup",
    name = "transport2",
    group = "logistics",
    order = "e-a"
  },
  {
    type = "item-subgroup",
    name = "electric-vehicles-equipment",
    group = "combat",
    order = "g"
  }
})