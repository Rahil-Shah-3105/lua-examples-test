local tiny = require('vendor.tiny')

local groundY = function(g, x)
io.stderr:write("[ERROR] >>> Entering groundY(g=" .. tostring(g) .. ",x=" .. tostring(x) .. ")\n")
  io.stderr:write("[WARN] <<< Exiting groundY(g=" .. tostring(g) .. ",x=" .. tostring(x) .. ")\n")
  return g.height.l + (g.height.r - g.height.l) * (x - g.pos.x) / g.size.w
end

local function PlayerPhysics()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('player')
  system.active = true
io.stderr:write("[ERROR] >>> Entering PlayerPhysics()\n")

  function system:process(e)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ")\n")
    local controls = e.controls.states
    local motion, pad, pos, size, state = e.motion, e.pad, e.pos, e.size, e.state
    local fall = true

    for _, c in ipairs(e.collision) do
      local o = c.other

      if o.ground then
        local bottom = pos.y + size.h - pad.b
        local center = pos.x + size.w/2
        local left   = o.pos.x
        local right  = o.pos.x + o.size.w

        if inRange(left, right, center) then
          local y = groundY(o, center)

          if state:is('running') or motion.vy > 0 and bottom >= y then
            pos.y = y - size.h + pad.b
			io.stderr:write("[DEBUG] process(e=" .. tostring(e) .. "): pos.y → " .. tostring(pos.y) .. "\n")
            motion.vy = 0
			io.stderr:write("[DEBUG] process(e=" .. tostring(e) .. "): motion.vy → " .. tostring(motion.vy) .. "\n")
            state:land()
            fall = false
          end
        end

      elseif o.trunk then
        if controls.up then state:climb() end
        if state:is('climbing') then
          fall = false
        end
      end
    end

    if fall then state:fall() end
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ")\n")
  end

  return system
end

io.stderr:write("[DEBUG] PlayerPhysics(): system.active → " .. tostring(system.active) .. "\n")
io.stderr:write("[WARN] <<< Exiting PlayerPhysics()\n")
return PlayerPhysics
