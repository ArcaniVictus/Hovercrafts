game.reload_script()


for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes
  if technologies["lcraft-tech"].researched then
    recipes["ehvt-equipment"].enabled = true
  end
end