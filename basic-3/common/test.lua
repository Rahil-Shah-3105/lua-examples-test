Object = require 'vendor/classic'
Test = Object:extend()

function Test:draw()
print(">>> Entering draw()")
  love.graphics.print("I am drawing on the screen.", 24, 24)
print("<<< Exiting draw()")
end

return Test