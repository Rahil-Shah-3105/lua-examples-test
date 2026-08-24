math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(p)
print("new(p=" .. tostring(p) .. "): duration → " .. tostring(duration) .. "")
print("new(p=" .. tostring(p) .. "): self.gold → " .. tostring(self.gold) .. "")
print(">>> Entering new(p=" .. tostring(p) .. ")")
  self.gold = p.gold
  self.day = 1
  self.animation = {
    duration = 1,
    current = 0
  }
print("new(p=" .. tostring(p) .. "): self.day → " .. tostring(self.day) .. "")
end

function Entity:sell(inventory, bonus)
print(">>> Entering sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. ")")
  local result = inventory:dump()

  self.gold = self.gold + result + bonus
print("sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. "): self.gold → " .. tostring(self.gold) .. "")

  if result == 0 then
    return false
  end

print("<<< Exiting sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. ")")
  return true
end

function Entity:spend(amount)
print(">>> Entering spend(amount=" .. tostring(amount) .. ")")
  if self.gold >= amount then
    self.gold = self.gold - amount
	print("spend(amount=" .. tostring(amount) .. "): self.gold → " .. tostring(self.gold) .. "")
    return amount
  end

print("<<< Exiting spend(amount=" .. tostring(amount) .. ")")
  return 0
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
    self.day = self.day + 1
	print("update(dt=" .. tostring(dt) .. "): self.day → " .. tostring(self.day) .. "")
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  width = love.graphics.getWidth()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("" .. self.gold .. "g", 16, 16, width, "left")

print("draw(): graphics → " .. tostring(graphics) .. "")
print("draw(): width → " .. tostring(width) .. "")
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("Day " .. self.day .. "", -16, 16, width, "right")
print("<<< Exiting draw()")
end

return Entity
