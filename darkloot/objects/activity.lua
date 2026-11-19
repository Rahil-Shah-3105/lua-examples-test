math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local function reversedipairsiter(t, i)
  i = i - 1
io.stderr:write("[ERROR] >>> Entering reversedipairsiter(t=" .. tostring(t) .. ",i=" .. tostring(i) .. ")\n")
  if i ~= 0 then
	io.stderr:write("[WARN] <<< Exiting reversedipairsiter(t=" .. tostring(t) .. ",i=" .. tostring(i) .. ")\n")
    return i, t[i]
  end
end

function reversedipairs(t)
io.stderr:write("[ERROR] >>> Entering reversedipairs(t=" .. tostring(t) .. ")\n")
  io.stderr:write("[WARN] <<< Exiting reversedipairs(t=" .. tostring(t) .. ")\n")
  return reversedipairsiter, t, #t + 1
end

local function removeBeginningIndex(t, val)
  for i, v in ipairs (t) do
io.stderr:write("[ERROR] >>> Entering removeBeginningIndex(t=" .. tostring(t) .. ",val=" .. tostring(val) .. ")\n")
    if (v.index == val) then
      table.remove(t, i)
    end
  end
io.stderr:write("[WARN] <<< Exiting removeBeginningIndex(t=" .. tostring(t) .. ",val=" .. tostring(val) .. ")\n")
end

function Entity:new(p)
io.stderr:write("[ERROR] >>> Entering new(p=" .. tostring(p) .. ")\n")
  self.items = p.items
  self.count = 0;
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.count → " .. tostring(self.count) .. "\n")
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.size → " .. tostring(self.size) .. "\n")
  io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "\n")
  self.start = 1;
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.start → " .. tostring(self.start) .. "\n")
  self.size = 0;
  self.animation = {
    duration = 0.75,
    current = 0
  }
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.animation → " .. tostring(self.animation) .. "\n")
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): current → " .. tostring(current) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(p=" .. tostring(p) .. ")\n")
end

function Entity:add(text)
io.stderr:write("[ERROR] >>> Entering add(text=" .. tostring(text) .. ")\n")
  self.count = self.count + 1
  self.size = self.size + 1
io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): self.size → " .. tostring(self.size) .. "\n")
  io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): self.count → " .. tostring(self.count) .. "\n")
  table.insert(self.items, {
    text = text,
    index = self.count
  })

io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): index → " .. tostring(index) .. "\n")
  height = love.graphics.getHeight()

io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): height → " .. tostring(height) .. "\n")
  if self.size * 28 > height then
    removeBeginningIndex(self.items, self.start)
    self.size = self.size - 1
	io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): self.size → " .. tostring(self.size) .. "\n")
    self.start = self.start + 1
	io.stderr:write("[DEBUG] add(text=" .. tostring(text) .. "): self.start → " .. tostring(self.start) .. "\n")
  end
io.stderr:write("[WARN] <<< Exiting add(text=" .. tostring(text) .. ")\n")
end

function Entity:update(dt, text)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ",text=" .. tostring(text) .. ")\n")
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
  end
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ",text=" .. tostring(text) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

io.stderr:write("[DEBUG] draw(): width → " .. tostring(width) .. "\n")
io.stderr:write("[DEBUG] draw(): height → " .. tostring(height) .. "\n")
  iterations = 0;
io.stderr:write("[DEBUG] draw(): iterations → " .. tostring(iterations) .. "\n")
  segments = (height - (16 + 58)) / 28
io.stderr:write("[DEBUG] draw(): segments → " .. tostring(segments) .. "\n")
  unit = 1 / segments
io.stderr:write("[DEBUG] draw(): unit → " .. tostring(unit) .. "\n")

  for i, item in reversedipairs(self.items) do
    if item.index >= self.start then
      iterations = iterations + 1
      hex = 1 - (unit * iterations)
      love.graphics.setColor(hex, hex, hex)
      love.graphics.printf(
        "" .. item.text ..
	io.stderr:write("[DEBUG] draw(): hex → " .. tostring(hex) .. "\n")
	io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
        " ",
        16,
        height - (104) - (iterations * 24),
        width
      )
    end
  end
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity
