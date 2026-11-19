local config = require('lib.config')
local tiny   = require('vendor.tiny')

local width = config.map.width

local function Wrap(res)
  local world   = res.world
io.stderr:write("[ERROR] >>> Entering Wrap(res=" .. tostring(res) .. ")\n")
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('wrap')
  local player
io.stderr:write("[WARN] <<< Exiting Wrap(res=" .. tostring(res) .. ")\n")

  function system:onAdd(e)
	io.stderr:write("[ERROR] >>> Entering onAdd(e=" .. tostring(e) .. ")\n")
    if e.player then player = e end
	io.stderr:write("[WARN] <<< Exiting onAdd(e=" .. tostring(e) .. ")\n")
  end

  function system:process(e)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ")\n")
    local ex, ey, px = e.pos.x, e.pos.y, player.pos.x

    if ex < px - width/2 then
      world.move(e, ex + width, ey, true)
    elseif ex > px + width/2 then
      world.move(e, ex - width, ey, true)
    end
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ")\n")
  end

  return system
end

return Wrap
