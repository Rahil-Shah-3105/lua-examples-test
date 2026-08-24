local config = require('lib.config')
local tiny   = require('vendor.tiny')

local width = config.map.width

local function Wrap(res)
  local world   = res.world
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('wrap')
  local player
print(">>> Entering Wrap(res=" .. tostring(res) .. ")")

  function system:onAdd(e)
	print(">>> Entering onAdd(e=" .. tostring(e) .. ")")
    if e.player then player = e end
	print("<<< Exiting onAdd(e=" .. tostring(e) .. ")")
  end

  function system:process(e)
	print(">>> Entering process(e=" .. tostring(e) .. ")")
    local ex, ey, px = e.pos.x, e.pos.y, player.pos.x

    if ex < px - width/2 then
      world.move(e, ex + width, ey, true)
    elseif ex > px + width/2 then
      world.move(e, ex - width, ey, true)
    end
	print("<<< Exiting process(e=" .. tostring(e) .. ")")
  end

print("<<< Exiting Wrap(res=" .. tostring(res) .. ")")
  return system
end

return Wrap
