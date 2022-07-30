-- control.lua
local drifting_multipliers = {
  ["hcraft-entity"] = 0.95, --2500  (weight)
  ["mcraft-entity"] = 0.97, --10000 (weight)
  ["ecraft-entity"] = 0.97, --7500  (weight)
  ["lcraft-entity"] = 0.95, --1500  (weight)
}
local isWaterTile = {
  ["water"] = true,
  ["deepwater"] = true
}
local isHovercraft = {
  ["hcraft-entity"] = true,
  ["ecraft-entity"] = true,
  ["mcraft-entity"] = true,
  ["lcraft-entity"] = true
}

function distance(pos1,pos2)
  local x = (pos1.x-pos2.x)^2
  local y = (pos1.y-pos2.y)^2
  return (x+y)^0.5
end

-- aesthetic ripple
local function make_ripple(player)
  local p = player.position
  local surface = player.surface
  if isWaterTile[surface.get_tile(p).name] then
    local r = 2.5
    local area = {{p.x - r, p.y - r}, {p.x + r, p.y + r}}
    if surface.count_tiles_filtered{area = area, name = "water", limit = 25} +
      surface.count_tiles_filtered{area = area, name = "deepwater", limit = 25} >= 25
    then      -- only ripple if in large water patch
      if player.driving then
        surface.create_entity{name = "water-ripple" .. math.random(1, 4) .. "-smoke", position={p.x,p.y+.75}}
      else
        surface.create_entity{name = "water-ripple" .. math.random(1, 4) .. "-smoke", position={p.x,p.y}}
      end
    end
  end
end


-- aesthetic splash
local function make_splash(player)
  if isWaterTile[player.surface.get_tile(player.position).name] then
    local driving = player.driving
    --if not driving or (driving and isHovercraft[player.vehicle.name]) then
    if (driving and isHovercraft[player.vehicle.name]) then
      local speed = 1+math.min(9,math.floor(math.abs(player.vehicle.speed)*9))
      player.surface.create_entity{name = "water-splash-smoke-"..speed, position = {player.vehicle.position.x+0.2,player.vehicle.position.y+0.5}}
    end
  end
end


-- when moving about in a hovercraft
script.on_event(defines.events.on_player_changed_position, function(e)
  local player = game.get_player(e.player_index)
  if player.character and not global.mods_installed.canal_builder then
    make_ripple(player)
    make_splash(player)
  end
end)


-- Now and then create smoke, ripple
local function tickHandler(e)
  local eTick = e.tick
  if eTick % 7==2 then
    for _,player in pairs(game.connected_players) do
      if player.character and player.driving then
        if isHovercraft[player.vehicle.name] then
          player.surface.create_trivial_smoke{name = "hover-smoke", position = player.position}
        end
      end
    end
  end
  if eTick % 120 == 4 then
    for _,player in pairs(game.connected_players) do
      if player.character and not global.mods_installed.canal_builder then
        make_ripple(player)
      end
    end
  end

  if global.settings["hovercraft-drifting"] then
    for unit_number, tbl in pairs(global.hovercrafts) do
      if tbl.entity and tbl.entity.valid then
        local pos = tbl.entity.position
        local speed = tbl.entity.speed
        if speed == 0 then
          tbl.idle_ticks = tbl.idle_ticks + 1
        else
          tbl.idle_ticks = 0
        end
        if tbl.idle_ticks < 120 then
        --local surroundings = #tbl.entity.surface.find_entities_filtered {area = {{pos.x-1, pos.y-1}, {pos.x+1, pos.y+1}}}
        --if speed ~=0 or surroundings == 1 then
          local drift_x = pos.x-tbl.position.x
          local drift_y = pos.y-tbl.position.y
          drift_x = drift_x*0.05+tbl.drift.x*0.95
          drift_y = drift_y*0.05+tbl.drift.y*0.95
          if (drift_x^2+drift_y^2)^0.5 >0.001 then
            local new_pos = {x = tbl.position.x+drift_x, y = tbl.position.y+drift_y}
            tbl.entity.teleport(-5,-5)
            local cliffsize = 2
            local cliffs = tbl.entity.surface.find_entities_filtered{ type = "cliff", area = {{new_pos.x-cliffsize, new_pos.y-cliffsize}, {new_pos.x+cliffsize, new_pos.y+cliffsize}} }
            local rocks = tbl.entity.surface.find_entities_filtered{ type = "simple-entity", area = {{new_pos.x-1, new_pos.y-1}, {new_pos.x+1, new_pos.y+1}} }
            if #cliffs > 0 or #rocks > 0 then
              local noncolliding = tbl.entity.surface.find_non_colliding_position("hovercraft-collision", new_pos, 0.1, 0.03)
              if noncolliding and distance(noncolliding,new_pos) < 0.04 then
                tbl.entity.teleport(noncolliding)
                tbl.idle_ticks = 120
              else
                tbl.entity.teleport(5,5)
                tbl.drift = {x=0,y=0}
                tbl.idle_ticks = 120
              end
            else
              if tbl.entity.surface.can_place_entity{name = "hovercraft-collision", position = new_pos, direction = tbl.entity.orientation} then
                tbl.entity.teleport(new_pos)
              else
                tbl.entity.teleport(5,5)
              end
            end
            tbl.drift = {x = drift_x, y = drift_y}
          else
            tbl.drift = {x = 0, y = 0}
          end
        else
          tbl.drift = {x = 0, y = 0}
        end
        tbl.position = tbl.entity.position
      else
        global.hovercrafts[unit_number] = nil
      end
    end
  end
end
script.on_event(defines.events.on_tick, tickHandler)


script.on_event(defines.events.on_entity_died, function(event)
  if isHovercraft[event.entity.name] then
    if global.hovercrafts[event.entity.unit_number] and global.hovercrafts[event.entity.unit_number].collision then
      global.hovercrafts[event.entity.unit_number].collision.destroy()
    end
  end
end)

function max_range(pos1,pos2,range)
  local distance = distance(pos1,pos2)
  pos2.x = pos2.x-pos1.x
  pos2.y = pos2.y-pos1.y
  pos2.x = pos2.x*math.min(1,range/distance)
  pos2.y = pos2.y*math.min(1,range/distance)
  pos1.x = pos1.x+pos2.x
  pos1.y = pos1.y+pos2.y
  return pos1
end

local function update_global_state()
  global.settings = {}
  global.settings["hovercraft-drifting"] = settings.global["hovercraft-drifting"].value
  global.mods_installed = {}
  global.mods_installed.laser_tanks = game.active_mods["laser_tanks"] or game.active_mods["laser_tanks_updated"]

  -- check for other mods that make water effects
  global.mods_installed.canal_builder = remote.interfaces["CanalBuilder"] and remote.interfaces["CanalBuilder"]["exists"]
end
script.on_event(defines.events.on_runtime_mod_setting_changed, update_global_state)

script.on_init(function()
  if remote.interfaces["electric-vehicles-lib"] and game.equipment_prototypes["ehvt-equipment"] then
    remote.call("electric-vehicles-lib", "register-transformer", {name = "ehvt-equipment"})
  end
  --[[if game.active_mods["electric-vehicles-lib-reborn"] or game.active_mods["laser_tanks"] and settings.startup["lasertanks-electric-engine"].value then
    remote.call("electric-vehicles-lib", "register-transformer", {name = "ehvt-equipment"})
  end]]--
  global.e_vehicles = { }
  global.braking_trains = { }
  global.braking_vehicles = { }
  global.transformers = { }
  global.brakes = { }
  global.vehicles={}
  global.hovercrafts = {}
  global.version = 10
  update_global_state()
end)

script.on_configuration_changed(function()
  if remote.interfaces["electric-vehicles-lib"] and game.equipment_prototypes["ehvt-equipment"] then
    remote.call("electric-vehicles-lib", "register-transformer", {name = "ehvt-equipment"})
  end
  if not global.version then
    --if game.active_mods["electric-vehicles-lib-reborn"] then
    --  remote.call("electric-vehicles-lib", "register-transformer", {name = "ehvt-equipment"})
    --end
    global.e_vehicles = {}
    global.braking_trains = {}
    global.braking_vehicles = {}
    global.transformers = {}
    global.brakes = {}
    global.vehicles = {}
    global.hovercrafts = {}
    global.version = 9
    for _, surface in pairs(game.surfaces) do
      local names = {}
      for name in pairs(isHovercraft) do
        table.insert(names,name)
      end
      entities = surface.find_entities_filtered{name = names}
      for _, entity in pairs(entities) do
        global.hovercrafts[entity.unit_number]={entity = entity,drift={x=0,y=0}, position = entity.position,idle_ticks = 0}-- direction = 0, speed = 0}
      end
    end
  end
  if global.version < 10 then
    for unit_number, tbl in pairs(global.hovercrafts) do
      if tbl.entity and tbl.entity.valid then
        global.hovercrafts[unit_number].last_speed = tbl.entity.speed
        global.hovercrafts[unit_number].last_pos = tbl.entity.position
      else
        global.hovercrafts[unit_number] = nil
      end
    end
    global.version = 10
  end
  update_global_state()
end)

script.on_event(defines.events.on_built_entity, function(event)
  if event.created_entity.name == "lcraft-entity" then
    table.insert(global.vehicles,event.created_entity)
  end
  if isHovercraft[event.created_entity.name] then
    --collision.set_driver(event.created_entity.surface.create_entity{name = "character", position = event.created_entity.position})
    global.hovercrafts[event.created_entity.unit_number] = {entity = event.created_entity,drift={x=0,y=0}, last_speed = 0, collision = collision, last_pos = event.created_entity.position, position = event.created_entity.position,idle_ticks = 0}-- direction = 0, speed = 0}
  end
end)


-------------------------------------------------------------
------------Laser tank script for lcraft's turret------------
-------------------------------------------------------------

TICKS_PER_UPDATE = 20 --*3 (per 3rd tick)
ENERGY_PER_CHARGE = 749998 -- wtf 500k is buggy?

function table_length(tbl)
  if tbl == nil then
    return 0
  else
    local count = 0
    for _ in pairs(tbl) do
      count = count + 1
    end
    return count
  end
end

script.on_nth_tick(3, function(event)
  if not global.mods_installed.laser_tanks then return end
  local temp_count = table_length(game.connected_players )
  local i

  local player_count = math.floor((temp_count+(global.tick_delayer or 0))/TICKS_PER_UPDATE)
  if not (player_count > 0) then
    global.tick_delayer = (global.tick_delayer or 0) + temp_count
  else
    global.tick_delayer = 0

    if not global.iterate_players then
      global.iterate_players = next(game.connected_players, global.iterate_players)
    elseif not game.connected_players [global.iterate_players] then
      global.iterate_players = nil
    end
    i = 0
    --maxruns = math.min(1,player_count) --max 20/s
    while i< player_count and global.iterate_players do
      if game.connected_players[global.iterate_players].character then
        local playerid = global.iterate_players
        local techlevel = 0
        if game.connected_players[playerid].force.technologies["laser-rifle-1"].researched then
          techlevel = 1
          if game.connected_players[playerid].force.technologies["laser-rifle-2"].researched then
            techlevel = 2
            if game.connected_players[playerid].force.technologies["laser-rifle-3"].researched then
              techlevel = 3
            end
          end
          local stack = game.connected_players[playerid].get_inventory(defines.inventory.character_main).find_item_stack("lasertanks-ammo-"..techlevel)
          if stack then
            stack.clear()
          end
          stack = game.connected_players[playerid].get_inventory(defines.inventory.character_main).find_item_stack("lasertanks-cannon-ammo-"..techlevel)
          if stack then
            stack.clear()
          end

          stack = game.connected_players[playerid].get_inventory(defines.inventory.character_ammo).find_item_stack("lasertanks-ammo-"..techlevel)
          if stack then
            stack.clear()
          end

          stack = game.connected_players[playerid].get_inventory(defines.inventory.character_ammo).find_item_stack("lasertanks-cannon-ammo-"..techlevel)
          if stack then
            stack.clear()
          end
        end
      end
      global.iterate_players = next(game.connected_players, global.iterate_players)  --iterating...
      if not global.iterate_players then
        global.iterate_players = next(game.connected_players, global.iterate_players)
      end
      i=i+1
    end
  end

  temp_count = table_length(global.vehicles)
  local vehicle_count = math.floor((temp_count+(global.tick_delayer_veh or 0))/TICKS_PER_UPDATE)
  if not (vehicle_count > 0) then
    global.tick_delayer_veh = (global.tick_delayer_veh or 0) + temp_count
  else
    global.tick_delayer_veh = 0

    if not global.iterate_vehicles then
      global.iterate_vehicles = next(global.vehicles, global.iterate_vehicles)
    elseif not global.vehicles [global.iterate_vehicles] then
      global.iterate_vehicles = nil
    end
    i = 0
    --maxruns = math.min(1,vehicle_count) --max 20/s
    while i< vehicle_count and global.iterate_vehicles do
      if not global.vehicles[global.iterate_vehicles].valid then
        global.vehicles[global.iterate_vehicles] = nil
        --game.players[1].print("invalid")
      else
        local vehicle = global.vehicles[global.iterate_vehicles]
        local techlevel = 0
        if vehicle.force.technologies["laser-rifle-1"].researched then
          techlevel = 1
          if vehicle.force.technologies["laser-rifle-2"].researched then
            techlevel = 2
            if vehicle.force.technologies["laser-rifle-3"].researched then
              techlevel = 3
            end
          end
          local stack = vehicle.get_inventory(defines.inventory.car_trunk).find_item_stack("lasertanks-ammo-"..techlevel)
          if stack then
            stack.clear()
          end
          stack = vehicle.get_inventory(defines.inventory.car_trunk).find_item_stack("lasertanks-cannon-ammo-"..techlevel)
          if stack then
            stack.clear()
          end
          local gun_index = 2
          if vehicle.name == "lcraft-entity" then
            gun_index = 1
          end
          local ammo = vehicle.get_inventory(defines.inventory.car_ammo)[gun_index]
          if not ammo.valid_for_read then
            ammo = 0
          else
            if ammo.name ~= "lasertanks-ammo-"..techlevel then
              ammo.set_stack{name = "lasertanks-ammo-"..techlevel, count = 1,ammo=ammo.ammo}
            end
            ammo = ammo.ammo
          end
          local cannon_ammo = 10
          if vehicle.name == "lasertank" then
            cannon_ammo = vehicle.get_inventory(defines.inventory.car_ammo)[1]
            if not cannon_ammo.valid_for_read then
              cannon_ammo = 0
            else
              if cannon_ammo.name ~= "lasertanks-cannon-ammo-"..techlevel then
                cannon_ammo.set_stack{name = "lasertanks-cannon-ammo-"..techlevel, count = 1,ammo=cannon_ammo.ammo}
              end
              cannon_ammo = cannon_ammo.ammo
            end
          end
          if ammo <50 or cannon_ammo < 10 then
            local energy = 0
            local modules = 0
            for _, eq in pairs(vehicle.grid.equipment) do
              if eq.name == "lcraft-charger" then
                energy = energy+eq.energy
                modules = modules+1
                --game.connected_players [playerid].print(eq.energy)
              end
            end
            local inserted = 0
            if ammo < cannon_ammo*5 then
              if energy >= ENERGY_PER_CHARGE/(2.5-techlevel*0.5) then
                inserted = math.min(50-ammo,math.floor(energy/(ENERGY_PER_CHARGE/(2.5-techlevel*0.5))))
                if ammo == 0 then
                  vehicle.get_inventory(defines.inventory.car_ammo)[gun_index].set_stack{name = "lasertanks-ammo-"..techlevel, count = 1,ammo=inserted}
                else
                  vehicle.get_inventory(defines.inventory.car_ammo)[gun_index].ammo = ammo+inserted
                end
              end
            else
              if energy >= ENERGY_PER_CHARGE*2/(2.5-techlevel*0.5) then
                inserted = math.min(10-cannon_ammo,math.floor(energy/(ENERGY_PER_CHARGE*2/(2.5-techlevel*0.5))))
                if cannon_ammo == 0 then
                  vehicle.get_inventory(defines.inventory.car_ammo)[1].set_stack{name = "lasertanks-ammo-"..techlevel, count = 1,ammo=inserted}
                else
                  vehicle.get_inventory(defines.inventory.car_ammo)[1].ammo = cannon_ammo+inserted
                end
                inserted = inserted * 2
              end
            end
            for _, eq in pairs(vehicle.grid.equipment) do
              if eq.name == "lcraft-charger" then
                eq.energy = eq.energy - inserted*(ENERGY_PER_CHARGE/(2.5-techlevel*0.5))/modules
              end
            end
          end
        end
      end
      global.iterate_vehicles = next(global.vehicles, global.iterate_vehicles)  --iterating...
      if not global.iterate_vehicles then
        global.iterate_vehicles = next(global.vehicles, global.iterate_vehicles)
      end
      i=i+1
    end
  end
end)
