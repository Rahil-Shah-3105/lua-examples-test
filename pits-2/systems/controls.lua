local config = require('lib.config')
local tiny   = require('vendor.tiny')

local function Controls()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls')

io.stderr:write("[ERROR] >>> Entering Controls()\n")
  local actions = {}

  function actions.jump(e)
	io.stderr:write("[ERROR] >>> Entering jump(e=" .. tostring(e) .. ")\n")
    local c, m, s = e.controls.states, e.motion, e.state
    if s:jump() then
      m.vy = c.turbo and math.abs(m.vx) > config.jump.threshold
        and config.jump.vmax
        or  config.jump.vmin
    end
	io.stderr:write("[WARN] <<< Exiting jump(e=" .. tostring(e) .. ")\n")
  end

  function actions.quit()
	io.stderr:write("[ERROR] >>> Entering quit()\n")
    love.event.push('quit')
	io.stderr:write("[WARN] <<< Exiting quit()\n")
  end

  local function climb(e)
    local c, m = e.controls.states, e.motion
	io.stderr:write("[ERROR] >>> Entering climb(e=" .. tostring(e) .. ")\n")
    local horz = c.right and 1 or (c.left and -1 or 0)
    local vert = c.up and -1 or (c.down and 1 or 0)
    m.vx = horz * config.climb.v
	io.stderr:write("[DEBUG] climb(e=" .. tostring(e) .. "): m.vx → " .. tostring(m.vx) .. "\n")
    m.vy = vert * config.climb.v
	io.stderr:write("[DEBUG] climb(e=" .. tostring(e) .. "): m.vy → " .. tostring(m.vy) .. "\n")
    m.ax = 0
	io.stderr:write("[DEBUG] climb(e=" .. tostring(e) .. "): m.ax → " .. tostring(m.ax) .. "\n")
  io.stderr:write("[WARN] <<< Exiting climb(e=" .. tostring(e) .. ")\n")
  end

  local function run(e)
    local c, m  = e.controls.states, e.motion
	io.stderr:write("[ERROR] >>> Entering run(e=" .. tostring(e) .. ")\n")
    local dir   = c.left and -1 or (c.right and 1 or 0)
    local vgoal = c.turbo and config.run.vmax or config.run.vmin
    m.ax = (dir == 0 and 2 or 1) * (dir * vgoal - m.vx) / config.run.dt
	io.stderr:write("[WARN] <<< Exiting run(e=" .. tostring(e) .. ")\n")
  end

  function system:process(e)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ")\n")
    local s = e.state
    for _, action in ipairs(e.controls.actions) do actions[action](e) end
    e.controls.actions = {}
    (s:is('climbing') and climb or run)(e)
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ")\n")
  end

  return system
end

io.stderr:write("[WARN] <<< Exiting Controls()\n")
return Controls
