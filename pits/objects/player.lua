require "objects/dynamic-entity"

Player = DynamicEntity:extend();

function getImageScaleForNewDimensions( image, newWidth, newHeight )
io.stderr:write("[ERROR] >>> Entering getImageScaleForNewDimensions(image=" .. tostring(image) .. ",newWidth=" .. tostring(newWidth) .. ",newHeight=" .. tostring(newHeight) .. ")\n")
  local currentWidth, currentHeight = image:getDimensions()
io.stderr:write("[WARN] <<< Exiting getImageScaleForNewDimensions(image=" .. tostring(image) .. ",newWidth=" .. tostring(newWidth) .. ",newHeight=" .. tostring(newHeight) .. ")\n")
  return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

function Player:new(x, y, w, h, world, mvx, mvy, speed)
io.stderr:write("[ERROR] >>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. ")\n")
  Player.super.new(self, x, y, w, h, nil, world, mvx, mvy, "PLAYER", 2)
  self.width = w
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.width → " .. tostring(self.width) .. "\n")
  self.height = h
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.height → " .. tostring(self.height) .. "\n")
  self.origX = x;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.origX → " .. tostring(self.origX) .. "\n")
  self.origY = 0;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.origY → " .. tostring(self.origY) .. "\n")
  self.speed = speed
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.speed → " .. tostring(self.speed) .. "\n")
  self.omvx = mvx;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.omvx → " .. tostring(self.omvx) .. "\n")
  self.tempDistance = ""
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.tempDistance → " .. tostring(self.tempDistance) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. ")\n")
end

function Player:update(dt)  
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  self.mvx = self.omvx

io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): self.mvx → " .. tostring(self.mvx) .. "\n")
  io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
  return self
end

function Player:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.setColor(1, 1, 1)
  image = assets[6]
io.stderr:write("[DEBUG] draw(): image → " .. tostring(image) .. "\n")
io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
  local scaleX, scaleY = getImageScaleForNewDimensions( image, 12, 12 )
  love.graphics.draw(image, self.x, self.y, 0, scaleX, scaleY)
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

function Player:checkCols(cols)
io.stderr:write("[ERROR] >>> Entering checkCols(cols=" .. tostring(cols) .. ")\n")
  Player.super:checkCols(cols)
  self.grounded = false
io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.grounded → " .. tostring(self.grounded) .. "\n")
  for i,v in ipairs (cols) do
    if cols[i].normal.y == -1 then
      self.yv = 0
	io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.yv → " .. tostring(self.yv) .. "\n")
      self.grounded = true
    elseif cols[i].normal.y == 1 then
      self.yv = -self.yv / 4
    end

    if cols[i].normal.x ~= 0 and cols[i].other.xv == nil then
      self.xv = 0
	io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.xv → " .. tostring(self.xv) .. "\n")
    end
  end
io.stderr:write("[WARN] <<< Exiting checkCols(cols=" .. tostring(cols) .. ")\n")
end

function Player:moveRight(dt)
io.stderr:write("[ERROR] >>> Entering moveRight(dt=" .. tostring(dt) .. ")\n")
  self.xv = self.xv + self.speed

io.stderr:write("[DEBUG] moveRight(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "\n")
  self.direction = 1
io.stderr:write("[DEBUG] moveRight(dt=" .. tostring(dt) .. "): self.direction → " .. tostring(self.direction) .. "\n")
  if self.direction == -1 then
    self.xv = 0
  end
io.stderr:write("[WARN] <<< Exiting moveRight(dt=" .. tostring(dt) .. ")\n")
end

function Player:moveLeft(dt)
io.stderr:write("[ERROR] >>> Entering moveLeft(dt=" .. tostring(dt) .. ")\n")
  self.xv = self.xv + self.speed

io.stderr:write("[DEBUG] moveLeft(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "\n")
  self.direction = -1
io.stderr:write("[DEBUG] moveLeft(dt=" .. tostring(dt) .. "): self.direction → " .. tostring(self.direction) .. "\n")
  if self.direction == 1 then
    self.xv = 0
  end
io.stderr:write("[WARN] <<< Exiting moveLeft(dt=" .. tostring(dt) .. ")\n")
end

function Player:jump(dt)
io.stderr:write("[ERROR] >>> Entering jump(dt=" .. tostring(dt) .. ")\n")
  if self.grounded == true then
    self.yv = self.yv - 300;
	io.stderr:write("[DEBUG] jump(dt=" .. tostring(dt) .. "): self.yv → " .. tostring(self.yv) .. "\n")
  end
io.stderr:write("[WARN] <<< Exiting jump(dt=" .. tostring(dt) .. ")\n")
end