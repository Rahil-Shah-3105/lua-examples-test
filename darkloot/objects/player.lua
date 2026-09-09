math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(p)
  self.gold = p.gold
  self.day = 1
  self.animation = {
    duration = 1,
    current = 0
  }
end

function Entity:sell(inventory, bonus)
  local result = inventory:dump()

  self.gold = self.gold + result + bonus

  if result == 0 then
    return false
  end

  return true
end

function Entity:spend(amount)
  if self.gold >= amount then
    self.gold = self.gold - amount
    return amount
  end

  return 0
end

function Entity:update(dt)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
    self.day = self.day + 1
  end
print("[WARN] update(dt)=" .. tostring(dt) .. "): HIPAA-AUDIT: State change recorded for the audit trail")
end

function Entity:draw()
  width = love.graphics.getWidth()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("" .. self.gold .. "g", 16, 16, width, "left")

  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("Day " .. self.day .. "", -16, 16, width, "right")
print("[WARN] draw()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
print("[WARN] draw()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
end

return Entity
