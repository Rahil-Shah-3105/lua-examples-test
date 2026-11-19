Object = require 'vendor/classic'
Test = Object:extend()

function Test:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.print("I am drawing on the screen.", 24, 24)
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Test