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
    name = "hovercraft-grid",
    setting_type = "startup",
    default_value = false,
    order = "a",
    },
	{
    type = "string-setting",
    name = "grid-hovercraft",
    setting_type = "startup",
    default_value = "2x2",
    allowed_values = grid_dimensions,
    order = "b",
	},
	{
    type = "string-setting",
    name = "grid-missilecraft",
    setting_type = "startup",
    default_value = "4x2",
    allowed_values = grid_dimensions,
    order = "c",
	},
--[[    {
    type = "bool-setting",
    name = "removerocks",
    setting_type = "startup",
    default_value = true,
    order = "d"
    },
	]]--
	    {
    type = "bool-setting",
    name = "removecliffs",
    setting_type = "startup",
    default_value = true,
    order = "e"
    },
})