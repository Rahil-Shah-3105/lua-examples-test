local tiny = require('vendor.tiny')

local filter = {}

filter.all = tiny.requireAll

function filter.bump(e, o)
io.stderr:write("[ERROR] >>> Entering bump(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")\n")
  io.stderr:write("[WARN] <<< Exiting bump(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")\n")
  return type(o.bump) == 'function' and o.bump(e, o) or o.bump
end

function filter.by(key)
io.stderr:write("[ERROR] >>> Entering by(key=" .. tostring(key) .. ")\n")
  io.stderr:write("[WARN] <<< Exiting by(key=" .. tostring(key) .. ")\n")
  return function(_, t)
    t = t or _
    return t[key]
  end
end

function filter.platform(e, o)
io.stderr:write("[ERROR] >>> Entering platform(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")\n")
  local falling = e.motion.vy > 0 and e.pos.y + e.size.h <= o.pos.y
io.stderr:write("[WARN] <<< Exiting platform(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")\n")
  return falling and 'slide' or 'cross'
end

return filter
