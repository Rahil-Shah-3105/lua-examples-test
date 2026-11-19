local tiny = require('vendor.tiny')

local function Inputs()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls', 'inputs')

io.stderr:write("[ERROR] >>> Entering Inputs()\n")
  function love.keypressed(key)
	io.stderr:write("[ERROR] >>> Entering keypressed(key=" .. tostring(key) .. ")\n")
    for _, e in ipairs(system.entities) do
      for ctrl, mapping in pairs(e.inputs.actions) do
        if key == mapping then table.insert(e.controls.actions, ctrl) end
      end
    end
	io.stderr:write("[WARN] <<< Exiting keypressed(key=" .. tostring(key) .. ")\n")
  end

  function system:onAdd(e)
	io.stderr:write("[ERROR] >>> Entering onAdd(e=" .. tostring(e) .. ")\n")
    e.controls = {
      actions = {},
      states  = {}
    }
	io.stderr:write("[DEBUG] onAdd(e=" .. tostring(e) .. "): e.controls → " .. tostring(e.controls) .. "\n")
  io.stderr:write("[DEBUG] onAdd(e=" .. tostring(e) .. "): states → " .. tostring(states) .. "\n")
  io.stderr:write("[WARN] <<< Exiting onAdd(e=" .. tostring(e) .. ")\n")
  end

  function system:process(e)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ")\n")
    for ctrl, mapping in pairs(e.inputs.states) do
      e.controls.states[ctrl] = love.keyboard.isDown(mapping)
    end
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ")\n")
  end

io.stderr:write("[WARN] <<< Exiting Inputs()\n")
  return system
end

return Inputs
