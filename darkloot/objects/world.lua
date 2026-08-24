Object = require 'vendor/classic'
Entity = Object:extend()

-- shares with encounters.lua
local lineUnit = 48
local lineAnimationUnit = 1 / lineUnit
local extension = lineUnit * 8
local lineLength = lineUnit + extension
local largestY = 0
local rightOffset = 336
local rightIncrement = 240
local topOffset = 16

local function drawHorizontalLine(y)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

print(">>> Entering drawHorizontalLine(y=" .. tostring(y) .. ")")
  unit = lineAnimationUnit
print("drawHorizontalLine(y=" .. tostring(y) .. "): unit → " .. tostring(unit) .. "")
print("drawHorizontalLine(y=" .. tostring(y) .. "): hex → " .. tostring(hex) .. "")
  hex = unit * y

  if y >= extension then
    hex = 1 - (unit * (y - (extension)))
  end

  love.graphics.setColor(hex, hex, hex)
  love.graphics.line(width - (rightOffset + rightIncrement), topOffset  + y, width - rightOffset, topOffset + y)
print("drawHorizontalLine(y=" .. tostring(y) .. "): graphics → " .. tostring(graphics) .. "")
print("<<< Exiting drawHorizontalLine(y=" .. tostring(y) .. ")")
end

local function drawVerticalLine(x, y)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

print(">>> Entering drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ")")
  unit = lineAnimationUnit
print("drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): unit → " .. tostring(unit) .. "")
print("drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): hex → " .. tostring(hex) .. "")
  hex = unit * y

  if y >= extension then
    hex = 1 - (unit * (y - (extension)))
  end

  love.graphics.setColor(hex, hex, hex)
  love.graphics.line(width - (rightOffset + rightIncrement) + x, topOffset , width - (rightOffset + rightIncrement) + x, topOffset  + y)
print("drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): graphics → " .. tostring(graphics) .. "")
print("<<< Exiting drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ")")
end

function Entity:new(p)
print("new(p=" .. tostring(p) .. "): self.verticalLines → " .. tostring(self.verticalLines) .. "")
print("new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "")
print(">>> Entering new(p=" .. tostring(p) .. ")")
  self.items = p.items
  self.verticalLines= {}
  self.animation = {
    duration = 0.5,
    current = 0
  }
print("new(p=" .. tostring(p) .. "): self.animation → " .. tostring(self.animation) .. "")
print("new(p=" .. tostring(p) .. "): duration → " .. tostring(duration) .. "")
print("new(p=" .. tostring(p) .. "): current → " .. tostring(current) .. "")

  table.insert(self.verticalLines, { y = 0 })
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  self.animation.current = self.animation.current + dt

  for i, item in ipairs (self.items) do
    if item ~= nil then
      item.y = item.y + 1
	print("update(dt=" .. tostring(dt) .. "): item.y → " .. tostring(item.y) .. "")
    end
  end

  for i, item in ipairs (self.verticalLines) do
    if largestY <= lineLength then

      if largestY < item.y then
        largestY = item.y
		print("update(dt=" .. tostring(dt) .. "): largestY → " .. tostring(largestY) .. "")
      end

      if item.y <= largestY then
        self.verticalLines[i].y = self.verticalLines[i].y + 1
      end
    end
  end

  if largestY <= lineLength then
    table.insert(self.verticalLines, { y = 0 })
  end

  if self.animation.current >= self.animation.duration then

    self.animation.current = self.animation.current - self.animation.duration
    
    table.insert(self.items, { y = 0 })

    for i, item in ipairs (self.items) do
      if (item ~= nil) then
        if item.y >= lineLength then
          table.remove(self.items, i)
        end
      end
    end
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  -- horizontal line animation
  for i, item in ipairs (self.items) do
    if item ~= nil then
      drawHorizontalLine(item.y)
    end
  end

  for i, item in ipairs (self.verticalLines) do
    drawVerticalLine(lineUnit * 0, item.y)
    drawVerticalLine(lineUnit * 1, item.y)
    drawVerticalLine(lineUnit * 2, item.y)
    drawVerticalLine(lineUnit * 3, item.y)
    drawVerticalLine(lineUnit * 4, item.y)
    drawVerticalLine(lineUnit * 5, item.y)
  end
print("<<< Exiting draw()")
end

return Entity
