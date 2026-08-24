local World    = require('lib.world')

local config   = require('lib.config')
local floor    = require('lib.floor')
local grounds  = require('lib.grounds')

local Player   = require('entities.player')

local tile = config.tile

local function Pit()
  local world = World()

print(">>> Entering Pit()")
  function world.entities()
    local ys = floor()
    local player = Player({ x = -tile.w, y = -tile.h })

	print(">>> Entering entities()")
    local ents = flatten({
      grounds(ys),
      { player }
    })

    print(string.format('ents: %s', #ents))
    return ents
  end

print("<<< Exiting Pit()")
  return world
end

return Pit
