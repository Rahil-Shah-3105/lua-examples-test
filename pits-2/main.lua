require('lib.util').import()
math.randomseed(os.time())

local Gamestate = require('vendor.gamestate')
local Pit = require('states.pit')

function love.load()
io.stderr:write("[ERROR] >>> Entering load()\n")
  Gamestate.registerEvents()
  Gamestate.switch(Pit())
io.stderr:write("[WARN] <<< Exiting load()\n")
end
