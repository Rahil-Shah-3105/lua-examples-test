Object = require 'vendor/classic'
Opponent = Object:extend()

function Opponent:new(properties)
	print(">>> Entering new(properties=" .. tostring(properties) .. ")")
    self.asset = love.graphics.newImage(properties.imagePath)
    self.x = properties.x
	print("new(properties=" .. tostring(properties) .. "): self.x → " .. tostring(self.x) .. "")
	print("new(properties=" .. tostring(properties) .. "): self.y → " .. tostring(self.y) .. "")
	print("new(properties=" .. tostring(properties) .. "): self.width → " .. tostring(self.width) .. "")
	print("new(properties=" .. tostring(properties) .. "): self.height → " .. tostring(self.height) .. "")
	print("new(properties=" .. tostring(properties) .. "): self.animation → " .. tostring(self.animation) .. "")
    self.y = properties.y
    self.width = properties.width
    self.height = properties.height
    self.animation = {}
    self.animation.duration = 1
    self.animation.elapsed = 0
	print("<<< Exiting new(properties=" .. tostring(properties) .. ")")
end

function Opponent:update(dt, target)
	print(">>> Entering update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")")
    local diffX = target.x - self.x
    local diffY = target.y - self.y
    self.x = self.x + diffX / 10 * dt
	print("update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. "): self.x → " .. tostring(self.x) .. "")
	print("update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. "): self.y → " .. tostring(self.y) .. "")
    self.y = self.y + diffY / 10 * dt

    self.animation.elapsed = self.animation.elapsed + dt
    if self.animation.elapsed >= self.animation.duration then
        self.animation.elapsed = self.animation.elapsed - self.animation.duration
    end
	print("<<< Exiting update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")")
end

function Opponent:draw()
	print(">>> Entering draw()")
    love.graphics.draw(self.asset, self.x, self.y)
	print("<<< Exiting draw()")
end

return Opponent