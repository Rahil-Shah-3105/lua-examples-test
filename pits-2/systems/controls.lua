local config = require('lib.config')
local tiny   = require('vendor.tiny')

local function Controls()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls')

print(">>> Entering Controls()")
  local actions = {}
print("<<< Exiting Controls()")

  function actions.jump(e)
	print(">>> Entering jump(e=" .. tostring(e) .. ")")
    local c, m, s = e.controls.states, e.motion, e.state
    if s:jump() then
      m.vy = c.turbo and math.abs(m.vx) > config.jump.threshold
        and config.jump.vmax
        or  config.jump.vmin
    end
	print("<<< Exiting jump(e=" .. tostring(e) .. ")")
  end

  function actions.quit()
	print(">>> Entering quit()")
    love.event.push('quit')
	print("<<< Exiting quit()")
  end

  local function climb(e)
    local c, m = e.controls.states, e.motion
	print(">>> Entering climb(e=" .. tostring(e) .. ")")
    local horz = c.right and 1 or (c.left and -1 or 0)
    local vert = c.up and -1 or (c.down and 1 or 0)
    m.vx = horz * config.climb.v
	print("climb(e=" .. tostring(e) .. "): m.vx → " .. tostring(m.vx) .. "")
	print("climb(e=" .. tostring(e) .. "): m.vy → " .. tostring(m.vy) .. "")
	print("climb(e=" .. tostring(e) .. "): m.ax → " .. tostring(m.ax) .. "")
  print("<<< Exiting climb(e=" .. tostring(e) .. ")")
    m.vy = vert * config.climb.v
    m.ax = 0
  end

  local function run(e)
    local c, m  = e.controls.states, e.motion
	print(">>> Entering run(e=" .. tostring(e) .. ")")
    local dir   = c.left and -1 or (c.right and 1 or 0)
    local vgoal = c.turbo and config.run.vmax or config.run.vmin
    m.ax = (dir == 0 and 2 or 1) * (dir * vgoal - m.vx) / config.run.dt
	print("<<< Exiting run(e=" .. tostring(e) .. ")")
  end

  function system:process(e)
    local s = e.state
    for _, action in ipairs(e.controls.actions) do actions[action](e) end
    e.controls.actions = {}
	print(">>> Entering process(e=" .. tostring(e) .. ")")
    (s:is('climbing') and climb or run)(e)
	print("<<< Exiting process(e=" .. tostring(e) .. ")")
  end

  return system
end

return Controls
