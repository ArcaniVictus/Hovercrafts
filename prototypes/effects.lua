-- Hover smoke
local hover_smoke = table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"])
hover_smoke.name = "hover-smoke"
hover_smoke.render_layer = "water-tile"
hover_smoke.affected_by_wind = false
hover_smoke.duration = 35
hover_smoke.start_scale = 1
hover_smoke.end_scale = 1.4
hover_smoke.fade_away_duration = 30
hover_smoke.fade_in_duration = 5
hover_smoke.spread_duration = 30
hover_smoke.animation.shift = {0,0}
data:extend({hover_smoke})

for i=1,10 do
  data:extend{{
    type = "smoke-with-trigger",
    name = "water-splash-smoke-" .. i,
    flags = {"not-on-map", "placeable-off-grid"},
    render_layer = "decorative",
    show_when_smoke_off = true,
    deviation = {0, 0},
    start_scale = 1,
    end_scale = 1,
    animation = {
      filename = HCGRAPHICS .. "/entity/effects/water-splash.png",
      priority = "extra-high",
      width = 92,
      height = 66,
      frame_count = 15,
      line_length = 5,
      shift = {-0.437, 0.5},
      animation_speed = 0.28, --0.35
      scale = 0.5+i/9,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = false,
    duration = 43,
    fade_away_duration = 0,
    spread_duration = 0,
    color = { r = 0.8, g = 0.8, b = 0.8 },
    action = nil,
    action_cooldown = 0
  }}
end

-- only add if not already there (from CanalBuilder mod)
if not data.raw["smoke-with-trigger"]["water-ripple1-smoke"] then
-- ripple animations
  for i=1,4 do
    data:extend{{
      type = "smoke-with-trigger",
      name = "water-ripple" .. i .. "-smoke",
      flags = {"not-on-map", "placeable-off-grid"},
      render_layer = "tile-transition",
      show_when_smoke_off = true,
      deviation = {0, 0},
      animation = {
        filename = HCGRAPHICS .. "/entity/effects/ripple" .. i .. ".png",
        priority = "extra-high",
        width = 192,
        height = 128,
        frame_count = 48,
        line_length = 8,
        shift = {0, 0.5},
        animation_speed = 0.25
      },
      slow_down_factor = 0,
      affected_by_wind = false,
      cyclic = false,
      duration = 192,
      fade_away_duration = 0,
      spread_duration = 0,
      color = {r = 0.3, g = 0.8, b = 0.9},
      action = nil,
      action_cooldown = 0
    }}
  end
end
