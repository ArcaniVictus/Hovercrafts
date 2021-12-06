require("constants")

if mods["traintunnels"] then
  data.raw["train-stop"]["train-stop"].collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile", "layer-14" }
  table.insert(data.raw["train-stop"]["traintunnel"].collision_mask, "layer-14")
  table.insert(data.raw["train-stop"]["traintunnelup"].collision_mask, "layer-14")
else
  data.raw["train-stop"]["train-stop"].collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile", "train-layer" }
end

local entity_types = {
  "accumulator",
  "ammo-turret",
  "arithmetic-combinator",
  "artillery-turret",
  --"artillery-wagon",
  "assembling-machine",
  "beacon",
  "boiler",
  "car",
  --"cargo-wagon",
  --"character-corpse",
  --"combat-robot",
  "constant-combinator",
  --"construction-robot",
  "container",
  --"corpse",
  --"curved-rail",
  "decider-combinator",
  "electric-energy-interface",
  "electric-pole",
  "electric-turret",
  "fluid-turret",
  --"fluid-wagon",
  "furnace",
  "gate",
  "generator",
  --"heat-interface",
  --"heat-pipe",
  "infinity-container",
  "infinity-pipe",
  "inserter",
  "item-request-proxy",
  "lab",
  --"lamp",
  --"land-mine",
  --"locomotive",
  "logistic-container",
  --"logistic-robot",
  "mining-drill",
  --"offshore-pump",
  "pipe",
  "pipe-to-ground",
  "character",
  --"player-port",
  "power-switch",
  "programmable-speaker",
  "pump",
  "radar",
  --"rail-chain-signal",
  --"rail-signal",
  "reactor",
  --"resource",
  "roboport",
  "rocket-silo",
  --"rocket-silo-rocket",
  "simple-entity",
  "simple-entity-with-force",
  "simple-entity-with-owner",
  "solar-panel",
  --"splitter",
  "storage-tank",
  --"straight-rail",
  --"transport-belt",
  "tree",
  "turret",
  --"underground-belt",
  "unit",
  "unit-spawner",
  "wall",
  "cliff",
  --"loader",
  --"loader-1x1",
  --"loader-1x2",
}

local collision_masks = {
  ["car"] = {"player-layer", "train-layer", "consider-tile-transitions"},
  ["character"] = {"player-layer", "train-layer", "consider-tile-transitions"},
  ["cliff"] = { "item-layer", "object-layer", "player-layer", "water-tile", "not-colliding-with-itself"},
  ["gate"] = {"item-layer", "object-layer", "player-layer", "water-tile", "train-layer"},
  ["loader"] = {"object-layer", "item-layer", "water-tile"},
  ["loader-1x1"] = {"object-layer", "item-layer", "water-tile"},
  ["loader-1x2"] = {"object-layer", "item-layer", "water-tile"},
  ["unit"] = {"player-layer", "train-layer", "not-colliding-with-itself"},
}

local default_collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}

for _, type in pairs(entity_types) do
  if not data.raw[type] then
    error("invalid type: "..type.." - please report a bug on the mod portal")
  end
  for name, proto in pairs(data.raw[type]) do
    local should_collide = 0
    for a,b in pairs(proto.collision_mask or collision_masks[type] or default_collision_mask) do
      if b == "player-layer" then
        should_collide = should_collide + 1
      elseif b == "train-layer" then
        should_collide = -999
      end
    end
    if should_collide > 0 then
      local temp_coll_mask = table.deepcopy(proto.collision_mask or collision_masks[type] or default_collision_mask)
      table.insert(temp_coll_mask, "train-layer")
      proto.collision_mask = temp_coll_mask
    end
  end
end

if mods["IndustrialRevolution"] then
  local prototypes = {
    data.raw["car"]["hcraft-entity"],
    data.raw["car"]["mcraft-entity"],
  }

  for _,prototype in pairs(prototypes) do
    if prototype and prototype.burner then
      prototype.burner.fuel_category = nil
      prototype.burner.fuel_categories = {"chemical", "battery"}
      prototype.burner.burnt_inventory_size = 1
    end
  end
end

if mods["DeadlockLargerLamp"] then
  data.raw["lamp"]["deadlock-large-lamp"].collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile", "train-layer"}
end
