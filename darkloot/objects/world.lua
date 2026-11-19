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

io.stderr:write("[ERROR] >>> Entering drawHorizontalLine(y=" .. tostring(y) .. ")\n")
  unit = lineAnimationUnit
io.stderr:write("[DEBUG] drawHorizontalLine(y=" .. tostring(y) .. "): unit → " .. tostring(unit) .. "\n")
  hex = unit * y
io.stderr:write("[DEBUG] drawHorizontalLine(y=" .. tostring(y) .. "): hex → " .. tostring(hex) .. "\n")

  if y >= extension then
    hex = 1 - (unit * (y - (extension)))
  end

  love.graphics.setColor(hex, hex, hex)
  love.graphics.line(width - (rightOffset + rightIncrement), topOffset  + y, width - rightOffset, topOffset + y)
io.stderr:write("[DEBUG] drawHorizontalLine(y=" .. tostring(y) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting drawHorizontalLine(y=" .. tostring(y) .. ")\n")
end

local function drawVerticalLine(x, y)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

io.stderr:write("[ERROR] >>> Entering drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ")\n")
  unit = lineAnimationUnit
io.stderr:write("[DEBUG] drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): unit → " .. tostring(unit) .. "\n")
  hex = unit * y
io.stderr:write("[DEBUG] drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): hex → " .. tostring(hex) .. "\n")

  if y >= extension then
    hex = 1 - (unit * (y - (extension)))
  end

  love.graphics.setColor(hex, hex, hex)
  love.graphics.line(width - (rightOffset + rightIncrement) + x, topOffset , width - (rightOffset + rightIncrement) + x, topOffset  + y)
io.stderr:write("[DEBUG] drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting drawVerticalLine(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ")\n")
end

function Entity:new(p)
io.stderr:write("[ERROR] >>> Entering new(p=" .. tostring(p) .. ")\n")
  self.items = p.items
  self.verticalLines= {}
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.verticalLines → " .. tostring(self.verticalLines) .. "\n")
  io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "\n")
  self.animation = {
    duration = 0.5,
    current = 0
  }
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.animation → " .. tostring(self.animation) .. "\n")
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): current → " .. tostring(current) .. "\n")

  table.insert(self.verticalLines, { y = 0 })
io.stderr:write("[WARN] <<< Exiting new(p=" .. tostring(p) .. ")\n")
end

function Entity:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  self.animation.current = self.animation.current + dt

  for i, item in ipairs (self.items) do
    if item ~= nil then
      item.y = item.y + 1
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): item.y → " .. tostring(item.y) .. "\n")
    end
  end

  for i, item in ipairs (self.verticalLines) do
    if largestY <= lineLength then

      if largestY < item.y then
        largestY = item.y
		io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): largestY → " .. tostring(largestY) .. "\n")
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
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
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
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity
