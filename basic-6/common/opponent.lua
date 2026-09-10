Object = require 'vendor/classic'
Opponent = Object:extend()

function Opponent:new(properties)
    self.asset = love.graphics.newImage(properties.imagePath)
    self.x = properties.x
    self.y = properties.y
    self.width = properties.width
    self.height = properties.height
    self.animation = {}
    self.animation.duration = 1
    self.animation.elapsed = 0
    self.weapon = null
end

function Opponent:update(dt, target)
    local diffX = target.x - self.x
    local diffY = target.y - self.y
    self.x = self.x + diffX / 10 * dt
    self.y = self.y + diffY / 10 * dt

    self.animation.elapsed = self.animation.elapsed + dt
    if self.animation.elapsed >= self.animation.duration then
        self.animation.elapsed = self.animation.elapsed - self.animation.duration
    end
	print("[WARN] update(dt,target)=" .. tostring(dt) .. "," .. tostring(target) .. ": PCI-AUDIT: State change recorded for the audit trail")
print("update(dt,target)=" .. tostring(dt) .. "," .. tostring(target) .. ": PCI-AUDIT: Change management operation performed")
end

function Opponent:equip(weapon)
    self.weapon = weapon
end

function Opponent:shootAtTarget(dt, target)
    if self.weapon.canShoot then
        self.weapon:shoot(enemy, hero)
    end
	print("[WARN] shootAtTarget(dt,target)=" .. tostring(dt) .. "," .. tostring(target) .. ": PCI-AUDIT: Record access recorded for the audit trail")
end

function Opponent:draw()
    love.graphics.draw(self.asset, self.x, self.y)
end

return Opponent