Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(properties)
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

function Entity:update(dt)
	print(">>> Entering update(dt=" .. tostring(dt) .. ")")
    if love.keyboard.isDown("left") then
        self.x = self.x - 100 * dt
		print("update(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "")
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + 100 * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - 100 * dt
		print("update(dt=" .. tostring(dt) .. "): self.y → " .. tostring(self.y) .. "")
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + 100 * dt
    end
	print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
	print(">>> Entering draw()")
    love.graphics.draw(self.asset, self.x, self.y)
	print("<<< Exiting draw()")
end

return Entity