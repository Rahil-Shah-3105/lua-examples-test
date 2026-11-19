Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(properties)
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
	io.stderr:write("[WARN] <<< Exiting new(properties=" .. tostring(properties) .. ")\n")
end

function Entity:update(dt)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
    if love.keyboard.isDown("left") then
        self.x = self.x - 100 * dt
		io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "\n")
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + 100 * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - 100 * dt
		io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.y → " .. tostring(self.y) .. "\n")
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + 100 * dt
    end
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Entity:draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    love.graphics.draw(self.asset, self.x, self.y)
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity