Object = require 'vendor/classic'
Opponent = Object:extend()

function Opponent:new(properties)
	io.stderr:write("[ERROR] >>> Entering new(properties=" .. tostring(properties) .. ")\n")
    self.asset = love.graphics.newImage(properties.imagePath)
    self.x = properties.x
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.x → " .. tostring(self.x) .. "\n")
    self.y = properties.y
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.y → " .. tostring(self.y) .. "\n")
    self.width = properties.width
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.width → " .. tostring(self.width) .. "\n")
    self.height = properties.height
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.height → " .. tostring(self.height) .. "\n")
    self.animation = {}
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.animation → " .. tostring(self.animation) .. "\n")
    self.animation.duration = 1
    self.animation.elapsed = 0
    self.weapon = null
	io.stderr:write("[DEBUG] new(properties=" .. tostring(properties) .. "): self.weapon → " .. tostring(self.weapon) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(properties=" .. tostring(properties) .. ")\n")
end

function Opponent:update(dt, target)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
    local diffX = target.x - self.x
    local diffY = target.y - self.y
    self.x = self.x + diffX / 10 * dt
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. "): self.x → " .. tostring(self.x) .. "\n")
    self.y = self.y + diffY / 10 * dt
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. "): self.y → " .. tostring(self.y) .. "\n")

    self.animation.elapsed = self.animation.elapsed + dt
    if self.animation.elapsed >= self.animation.duration then
        self.animation.elapsed = self.animation.elapsed - self.animation.duration
    end
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
end

function Opponent:equip(weapon)
	io.stderr:write("[ERROR] >>> Entering equip(weapon=" .. tostring(weapon) .. ")\n")
    self.weapon = weapon
	io.stderr:write("[DEBUG] equip(weapon=" .. tostring(weapon) .. "): self.weapon → " .. tostring(self.weapon) .. "\n")
io.stderr:write("[WARN] <<< Exiting equip(weapon=" .. tostring(weapon) .. ")\n")
end

function Opponent:shootAtTarget(dt, target)
	io.stderr:write("[ERROR] >>> Entering shootAtTarget(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
    if self.weapon.canShoot then
        self.weapon:shoot(enemy, hero)
    end
	io.stderr:write("[WARN] <<< Exiting shootAtTarget(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
end

function Opponent:draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    love.graphics.draw(self.asset, self.x, self.y)
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Opponent