local World    = require('lib.world')

local config   = require('lib.config')
local floor    = require('lib.floor')
local grounds  = require('lib.grounds')

local Player   = require('entities.player')

local tile = config.tile

local function Pit()
  local world = World()

io.stderr:write("[ERROR] >>> Entering Pit()\n")
  function world.entities()
	io.stderr:write("[ERROR] >>> Entering entities()\n")
    local ys = floor()
    local player = Player({ x = -tile.w, y = -tile.h })

    local ents = flatten({
      grounds(ys),
      { player }
    })

    print(string.format('ents: %s', #ents))
	io.stderr:write("[WARN] <<< Exiting entities()\n")
    return ents
  end

io.stderr:write("[WARN] <<< Exiting Pit()\n")
  return world
end

return Pit
