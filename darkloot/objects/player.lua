math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(p)
io.stderr:write("[ERROR] >>> Entering new(p=" .. tostring(p) .. ")\n")
  self.gold = p.gold
  self.day = 1
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.day → " .. tostring(self.day) .. "\n")
  io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.gold → " .. tostring(self.gold) .. "\n")
  self.animation = {
    duration = 1,
    current = 0
  }
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.animation → " .. tostring(self.animation) .. "\n")
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): current → " .. tostring(current) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(p=" .. tostring(p) .. ")\n")
end

function Entity:sell(inventory, bonus)
io.stderr:write("[ERROR] >>> Entering sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. ")\n")
  local result = inventory:dump()

  self.gold = self.gold + result + bonus
io.stderr:write("[DEBUG] sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. "): self.gold → " .. tostring(self.gold) .. "\n")

  if result == 0 then
    return false
  end

io.stderr:write("[WARN] <<< Exiting sell(inventory=" .. tostring(inventory) .. ",bonus=" .. tostring(bonus) .. ")\n")
  return true
end

function Entity:spend(amount)
io.stderr:write("[ERROR] >>> Entering spend(amount=" .. tostring(amount) .. ")\n")
  if self.gold >= amount then
    self.gold = self.gold - amount
	io.stderr:write("[DEBUG] spend(amount=" .. tostring(amount) .. "): self.gold → " .. tostring(self.gold) .. "\n")
    return amount
  end

io.stderr:write("[WARN] <<< Exiting spend(amount=" .. tostring(amount) .. ")\n")
  return 0
end

function Entity:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
    self.day = self.day + 1
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.day → " .. tostring(self.day) .. "\n")
  end
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  width = love.graphics.getWidth()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("" .. self.gold .. "g", 16, 16, width, "left")

io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("Day " .. self.day .. "", -16, 16, width, "right")
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity
