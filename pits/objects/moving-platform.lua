math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
io.stderr:write("[ERROR] >>> Entering new(state=" .. tostring(state) .. ")\n")
  self.width = state.width
  self.height = state.height
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.height → " .. tostring(self.height) .. "\n")
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.dropping → " .. tostring(self.dropping) .. "\n")
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.width → " .. tostring(self.width) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(state=" .. tostring(state) .. ")\n")
  self.x = state.x
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.x → " .. tostring(self.x) .. "\n")
  self.y = state.y
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.y → " .. tostring(self.y) .. "\n")
  self.direction = state.direction
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.direction → " .. tostring(self.direction) .. "\n")
  self.yv = 0
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.yv → " .. tostring(self.yv) .. "\n")
  self.xv = 0
io.stderr:write("[DEBUG] new(state=" .. tostring(state) .. "): self.xv → " .. tostring(self.xv) .. "\n")
  self.dropping = 0
end

function Entity:update(dt)
  if self.direction == 1 then
    self.yv = -2000 * dt
    if self.dropping > 0 then
      self.yv = 2000 * dt
      self.y = self.y + self.yv * dt
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

io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "\n")
io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.y → " .. tostring(self.y) .. "\n")
  -- the blocks can't go too far left.
  if self.x < 0 then
    self.x = 0
  end
io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "\n")

  -- dont let the blocks go too far right
  if self.x > love.graphics.getWidth() - 32 then
    self.x = love.graphics.getWidth() - 32
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.yv → " .. tostring(self.yv) .. "\n")
  end

  -- the blocks can't go too far down.
  if self.y > love.graphics.getHeight() - 32 then
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.dropping → " .. tostring(self.dropping) .. "\n")
    self.y = love.graphics.getHeight() - 32
  end
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.setColor(1, 1, 1)

io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
  local image
  if self.direction == 1 then
    image = assets[2]
	io.stderr:write("[DEBUG] draw(): image → " .. tostring(image) .. "\n")
  elseif self.direction == 2 then
    image = assets[4]
  elseif self.direction == 3 then
    image = assets[3]
  else
    image = assets[5]
	io.stderr:write("[WARN] <<< Exiting draw()\n")
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


