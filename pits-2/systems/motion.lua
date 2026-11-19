local tiny = require('vendor.tiny')

local function Motion(res)
  local world   = res.world
io.stderr:write("[ERROR] >>> Entering Motion(res=" .. tostring(res) .. ")\n")
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('motion', 'pos')

io.stderr:write("[WARN] <<< Exiting Motion(res=" .. tostring(res) .. ")\n")
  function system:process(e, dt)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ",dt=" .. tostring(dt) .. ")\n")
    local m, p = e.motion, e.pos

    local x = p.x + m.vx * dt
    local y = p.y + m.vy * dt

    m.vx = m.vx + (m.ax or 0) * dt
    m.vy = m.vy + (m.ay or 0) * dt

    world.move(e, x, y)
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ",dt=" .. tostring(dt) .. ")\n")
  end

  return system
end

return Motion
