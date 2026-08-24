math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
print(">>> Entering new(state=" .. tostring(state) .. ")")
  self.width = state.width
  self.height = state.height
print("new(state=" .. tostring(state) .. "): self.height → " .. tostring(self.height) .. "")
print("new(state=" .. tostring(state) .. "): self.x → " .. tostring(self.x) .. "")
print("new(state=" .. tostring(state) .. "): self.y → " .. tostring(self.y) .. "")
print("new(state=" .. tostring(state) .. "): self.name → " .. tostring(self.name) .. "")
print("new(state=" .. tostring(state) .. "): self.width → " .. tostring(self.width) .. "")
print("<<< Exiting new(state=" .. tostring(state) .. ")")
  self.x = state.x
  self.y = state.y
  self.name = state.name
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
--
end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")

function Entity:draw()
print(">>> Entering draw()")
  love.graphics.setColor(1, 1, 1)
  image = assets[7]
print("draw(): image → " .. tostring(image) .. "")
print("draw(): graphics → " .. tostring(graphics) .. "")
print("<<< Exiting draw()")
  love.graphics.draw(image, self.x, self.y)
end

return Entity