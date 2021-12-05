-- settings.lua

local grid_dimensions = {
  "2x2",
  "4x2",
  "4x4",
  "6x2",
  "6x4",
  "6x6",
  "8x2",
  "8x4",
  "8x6",
  "8x8",
  "10x2",
}

data:extend({
  {
    type = "bool-setting",
    name = "hovercraft-drifting",
    setting_type = "runtime-global",
    default_value = true
  },
  {
    type = "bool-setting",
    name = "enable-ecraft",
    setting_type = "startup",
    default_value = true,
    order = "b",
  },
  {
    type = "bool-setting",
    name = "enable-mcraft",
    setting_type = "startup",
    default_value = true,
    order = "c",
  },
  {
    type = "bool-setting",
    name = "enable-lcraft",
    setting_type = "startup",
    default_value = true,
    order = "d",
  },
  {
    type = "bool-setting",
    name = "hovercraft-grid",
    setting_type = "startup",
    default_value = false,
    order = "e",
  },
  {
    type = "string-setting",
    name = "grid-hcraft",
    setting_type = "startup",
    default_value = "2x2",
    allowed_values = grid_dimensions,
    order = "f",
  },
  {
    type = "string-setting",
    name = "grid-mcraft",
    setting_type = "startup",
    default_value = "4x2",
    allowed_values = grid_dimensions,
    order = "g",
  },
    --[[{
    type = "bool-setting",
    name = "removerocks",
    setting_type = "startup",
    default_value = false,
    order = "h"
    },]]--
})