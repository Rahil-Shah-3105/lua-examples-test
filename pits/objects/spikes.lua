math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
io.stderr:write("[ERROR] >>> Entering new(state=" .. tostring(state) .. ")\n")
  self.width = state.width
  self.height = state.height
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.height → " .. tostring(self.height) .. "\n")
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.name → " .. tostring(self.name) .. "\n")
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.width → " .. tostring(self.width) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(state=" .. tostring(state) .. ")\n")
  self.x = state.x
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.x → " .. tostring(self.x) .. "\n")
  self.y = state.y
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.y → " .. tostring(self.y) .. "\n")
  self.name = state.name
end

function Entity:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
--
end
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.setColor(1, 1, 1)
  image = assets[7]
io.stderr:write("[DEBUG] draw(): image → " .. tostring(image) .. "\n")
io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting draw()\n")
  love.graphics.draw(image, self.x, self.y)
end

return Entity