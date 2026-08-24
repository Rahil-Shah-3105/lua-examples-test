local tiny = require('vendor.tiny')

local function Motion(res)
  local world   = res.world
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('motion', 'pos')

print(">>> Entering Motion(res=" .. tostring(res) .. ")")
  function system:process(e, dt)
	print(">>> Entering process(e=" .. tostring(e) .. ",dt=" .. tostring(dt) .. ")")
    local m, p = e.motion, e.pos

    local x = p.x + m.vx * dt
    local y = p.y + m.vy * dt

    m.vx = m.vx + (m.ax or 0) * dt
    m.vy = m.vy + (m.ay or 0) * dt

    world.move(e, x, y)
	print("<<< Exiting process(e=" .. tostring(e) .. ",dt=" .. tostring(dt) .. ")")
  end

print("<<< Exiting Motion(res=" .. tostring(res) .. ")")
  return system
end

return Motion
