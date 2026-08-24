math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local function reversedipairsiter(t, i)
  i = i - 1
print(">>> Entering reversedipairsiter(t=" .. tostring(t) .. ",i=" .. tostring(i) .. ")")
  if i ~= 0 then
    return i, t[i]
  end
print("<<< Exiting reversedipairsiter(t=" .. tostring(t) .. ",i=" .. tostring(i) .. ")")
end

function reversedipairs(t)
print(">>> Entering reversedipairs(t=" .. tostring(t) .. ")")
  print("<<< Exiting reversedipairs(t=" .. tostring(t) .. ")")
  return reversedipairsiter, t, #t + 1
end

local function removeBeginningIndex(t, val)
  for i, v in ipairs (t) do
print(">>> Entering removeBeginningIndex(t=" .. tostring(t) .. ",val=" .. tostring(val) .. ")")
    if (v.index == val) then
      table.remove(t, i)
    end
  end
print("<<< Exiting removeBeginningIndex(t=" .. tostring(t) .. ",val=" .. tostring(val) .. ")")
end

function Entity:new(p)
print(">>> Entering new(p=" .. tostring(p) .. ")")
print("new(p=" .. tostring(p) .. "): self.animation → " .. tostring(self.animation) .. "")
print("new(p=" .. tostring(p) .. "): self.count → " .. tostring(self.count) .. "")
print("new(p=" .. tostring(p) .. "): self.start → " .. tostring(self.start) .. "")
print("new(p=" .. tostring(p) .. "): self.size → " .. tostring(self.size) .. "")
  self.items = p.items
  self.count = 0;
  self.start = 1;
  self.size = 0;
  self.animation = {
    duration = 0.75,
    current = 0
  }
print("new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "")
print("<<< Exiting new(p=" .. tostring(p) .. ")")
end

function Entity:add(text)
  self.count = self.count + 1
print("add(text=" .. tostring(text) .. "): self.count → " .. tostring(self.count) .. "")
print(">>> Entering add(text=" .. tostring(text) .. ")")
  self.size = self.size + 1
  table.insert(self.items, {
    text = text,
    index = self.count
  })

print("add(text=" .. tostring(text) .. "): self.size → " .. tostring(self.size) .. "")
print("add(text=" .. tostring(text) .. "): index → " .. tostring(index) .. "")
print("add(text=" .. tostring(text) .. "): height → " .. tostring(height) .. "")
  height = love.graphics.getHeight()

  if self.size * 28 > height then
    removeBeginningIndex(self.items, self.start)
    self.size = self.size - 1
    self.start = self.start + 1
	print("add(text=" .. tostring(text) .. "): self.start → " .. tostring(self.start) .. "")
  end
print("<<< Exiting add(text=" .. tostring(text) .. ")")
end

function Entity:update(dt, text)
print(">>> Entering update(dt=" .. tostring(dt) .. ",text=" .. tostring(text) .. ")")
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ",text=" .. tostring(text) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

print("draw(): width → " .. tostring(width) .. "")
print("draw(): height → " .. tostring(height) .. "")
print("draw(): iterations → " .. tostring(iterations) .. "")
print("draw(): segments → " .. tostring(segments) .. "")
print("draw(): unit → " .. tostring(unit) .. "")
  iterations = 0;
  segments = (height - (16 + 58)) / 28
  unit = 1 / segments

  for i, item in reversedipairs(self.items) do
    if item.index >= self.start then
      iterations = iterations + 1
      hex = 1 - (unit * iterations)
      love.graphics.setColor(hex, hex, hex)
      love.graphics.printf(
        "" .. item.text ..
	print("draw(): hex → " .. tostring(hex) .. "")
	print("draw(): graphics → " .. tostring(graphics) .. "")
        " ",
        16,
        height - (104) - (iterations * 24),
        width
      )
    end
  end
print("<<< Exiting draw()")
end

return Entity
