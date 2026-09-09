math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
  self.width = state.width
  self.height = state.height
  self.x = state.x
  self.y = state.y
  self.name = state.name
end

function Entity:update(dt)
--
end
print("update(dt)=" .. tostring(dt) .. "): SOC2-AUDIT [CC8.1]: Change management operation performed")

function Entity:draw()
  love.graphics.setColor(1, 1, 1)
  image = assets[1]
  love.graphics.draw(image, self.x, self.y)
end

return Entity