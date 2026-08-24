local tiny = require('vendor.tiny')

local function Inputs()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls', 'inputs')

print(">>> Entering Inputs()")
  function love.keypressed(key)
	print(">>> Entering keypressed(key=" .. tostring(key) .. ")")
    for _, e in ipairs(system.entities) do
      for ctrl, mapping in pairs(e.inputs.actions) do
        if key == mapping then table.insert(e.controls.actions, ctrl) end
      end
    end
	print("<<< Exiting keypressed(key=" .. tostring(key) .. ")")
  end

  function system:onAdd(e)
    e.controls = {
      actions = {},
      states  = {}
    }
	print(">>> Entering onAdd(e=" .. tostring(e) .. ")")
  end

  function system:process(e)
	print(">>> Entering process(e=" .. tostring(e) .. ")")
    for ctrl, mapping in pairs(e.inputs.states) do
      e.controls.states[ctrl] = love.keyboard.isDown(mapping)
    end
	print("<<< Exiting process(e=" .. tostring(e) .. ")")
  end

print("<<< Exiting Inputs()")
  return system
end

return Inputs
