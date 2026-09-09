local config = require('lib.config')
local tiny   = require('vendor.tiny')

local width = config.map.width

local function Wrap(res)
  local world   = res.world
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('wrap')
  local player

  function system:onAdd(e)
    if e.player then player = e end
	print("[WARN] onAdd(e)=" .. tostring(e) .. "): HIPAA-AUDIT: State change recorded for the audit trail")
  end

  function system:process(e)
    local ex, ey, px = e.pos.x, e.pos.y, player.pos.x

    if ex < px - width/2 then
      world.move(e, ex + width, ey, true)
    elseif ex > px + width/2 then
      world.move(e, ex - width, ey, true)
    end
	print("[WARN] process(e)=" .. tostring(e) .. "): HIPAA-AUDIT: State change recorded for the audit trail")
  end

  return system
end

return Wrap
