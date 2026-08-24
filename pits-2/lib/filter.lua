local tiny = require('vendor.tiny')

local filter = {}

filter.all = tiny.requireAll

function filter.bump(e, o)
print(">>> Entering bump(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")")
  return type(o.bump) == 'function' and o.bump(e, o) or o.bump
end

function filter.by(key)
print(">>> Entering by(key=" .. tostring(key) .. ")")
  return function(_, t)
    t = t or _
    return t[key]
  end
print("<<< Exiting by(key=" .. tostring(key) .. ")")
end

function filter.platform(e, o)
print(">>> Entering platform(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")")
  local falling = e.motion.vy > 0 and e.pos.y + e.size.h <= o.pos.y
print("<<< Exiting platform(e=" .. tostring(e) .. ",o=" .. tostring(o) .. ")")
  return falling and 'slide' or 'cross'
end

return filter
