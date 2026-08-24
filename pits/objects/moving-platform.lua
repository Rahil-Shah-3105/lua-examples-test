math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
print(">>> Entering new(state=" .. tostring(state) .. ")")
  self.width = state.width
  self.height = state.height
print("new(state=" .. tostring(state) .. "): self.height → " .. tostring(self.height) .. "")
print("new(state=" .. tostring(state) .. "): self.x → " .. tostring(self.x) .. "")
print("new(state=" .. tostring(state) .. "): self.y → " .. tostring(self.y) .. "")
print("new(state=" .. tostring(state) .. "): self.direction → " .. tostring(self.direction) .. "")
print("new(state=" .. tostring(state) .. "): self.yv → " .. tostring(self.yv) .. "")
print("new(state=" .. tostring(state) .. "): self.xv → " .. tostring(self.xv) .. "")
print("new(state=" .. tostring(state) .. "): self.dropping → " .. tostring(self.dropping) .. "")
print("new(state=" .. tostring(state) .. "): self.width → " .. tostring(self.width) .. "")
print("<<< Exiting new(state=" .. tostring(state) .. ")")
  self.x = state.x
  self.y = state.y
  self.direction = state.direction
  self.yv = 0
  self.xv = 0
  self.dropping = 0
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  if self.direction == 1 then
    self.yv = -2000 * dt
	print("update(dt=" .. tostring(dt) .. "): self.yv → " .. tostring(self.yv) .. "")
    if self.dropping > 0 then
      self.yv = 2000 * dt
      self.y = self.y + self.yv * dt
	print("update(dt=" .. tostring(dt) .. "): self.y → " .. tostring(self.y) .. "")
	print("update(dt=" .. tostring(dt) .. "): self.dropping → " .. tostring(self.dropping) .. "")
      self.dropping = self.dropping - 1
    else
      self.y = self.y + self.yv * dt
    end
  end

  if self.direction == 0 then
    self.yv = 2000 * dt
    self.y = self.y + self.yv * dt
  end

  if self.direction == 2 then
    self.xv = 2000 * dt
	print("update(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "")
	print("update(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "")
    self.x = self.x + self.xv * dt
  end

  -- moving platforms right.
  if self.direction == 3 then
    self.xv = -2000 * dt
    self.x = self.x + self.xv * dt
  end

  -- the blocks can't go too far up.
  if self.y < 0 then
    self.y = 0
  end

  -- the blocks can't go too far left.
  if self.x < 0 then
    self.x = 0
  end

  -- dont let the blocks go too far right
  if self.x > love.graphics.getWidth() - 32 then
    self.x = love.graphics.getWidth() - 32
  end

  -- the blocks can't go too far down.
  if self.y > love.graphics.getHeight() - 32 then
    self.y = love.graphics.getHeight() - 32
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  love.graphics.setColor(1, 1, 1)

print("draw(): graphics → " .. tostring(graphics) .. "")
  local image
  if self.direction == 1 then
    image = assets[2]
	print("draw(): image → " .. tostring(image) .. "")
  elseif self.direction == 2 then
    image = assets[4]
  elseif self.direction == 3 then
    image = assets[3]
  else
    image = assets[5]
	print("<<< Exiting draw()")
  end

love.graphics.draw(image, self.x, self.y)
  -- love.graphics.rectangle(
  --   'fill',
  --  self.x,
  --  self.y,
  --  self.width,
  --  self.height
  -- )
end

return Entity


