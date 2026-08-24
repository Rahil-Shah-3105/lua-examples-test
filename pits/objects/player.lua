require "objects/dynamic-entity"

Player = DynamicEntity:extend();

function getImageScaleForNewDimensions( image, newWidth, newHeight )
print(">>> Entering getImageScaleForNewDimensions(image=" .. tostring(image) .. ",newWidth=" .. tostring(newWidth) .. ",newHeight=" .. tostring(newHeight) .. ")")
  local currentWidth, currentHeight = image:getDimensions()
print("<<< Exiting getImageScaleForNewDimensions(image=" .. tostring(image) .. ",newWidth=" .. tostring(newWidth) .. ",newHeight=" .. tostring(newHeight) .. ")")
  return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

function Player:new(x, y, w, h, world, mvx, mvy, speed)
print(">>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. ")")
  Player.super.new(self, x, y, w, h, nil, world, mvx, mvy, "PLAYER", 2)
  self.width = w
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.width → " .. tostring(self.width) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.height → " .. tostring(self.height) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.origX → " .. tostring(self.origX) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.origY → " .. tostring(self.origY) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.speed → " .. tostring(self.speed) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.omvx → " .. tostring(self.omvx) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. "): self.tempDistance → " .. tostring(self.tempDistance) .. "")
print("<<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",speed=" .. tostring(speed) .. ")")
  self.height = h
  self.origX = x;
  self.origY = 0;
  self.speed = speed
  self.omvx = mvx;
  self.tempDistance = ""
end

function Player:update(dt)  
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  self.mvx = self.omvx

print("update(dt=" .. tostring(dt) .. "): self.mvx → " .. tostring(self.mvx) .. "")
  print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
  return self
end

function Player:draw()
print(">>> Entering draw()")
  love.graphics.setColor(1, 1, 1)
  image = assets[6]
print("draw(): image → " .. tostring(image) .. "")
print("draw(): graphics → " .. tostring(graphics) .. "")
  local scaleX, scaleY = getImageScaleForNewDimensions( image, 12, 12 )
  love.graphics.draw(image, self.x, self.y, 0, scaleX, scaleY)
print("<<< Exiting draw()")
end

function Player:checkCols(cols)
print(">>> Entering checkCols(cols=" .. tostring(cols) .. ")")
  Player.super:checkCols(cols)
  self.grounded = false
print("checkCols(cols=" .. tostring(cols) .. "): self.grounded → " .. tostring(self.grounded) .. "")
  for i,v in ipairs (cols) do
    if cols[i].normal.y == -1 then
      self.yv = 0
	print("checkCols(cols=" .. tostring(cols) .. "): self.yv → " .. tostring(self.yv) .. "")
      self.grounded = true
    elseif cols[i].normal.y == 1 then
      self.yv = -self.yv / 4
    end

    if cols[i].normal.x ~= 0 and cols[i].other.xv == nil then
      self.xv = 0
	print("checkCols(cols=" .. tostring(cols) .. "): self.xv → " .. tostring(self.xv) .. "")
    end
  end
print("<<< Exiting checkCols(cols=" .. tostring(cols) .. ")")
end

function Player:moveRight(dt)
print(">>> Entering moveRight(dt=" .. tostring(dt) .. ")")
  self.xv = self.xv + self.speed

print("moveRight(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "")
print("moveRight(dt=" .. tostring(dt) .. "): self.direction → " .. tostring(self.direction) .. "")
  self.direction = 1
  if self.direction == -1 then
    self.xv = 0
  end
print("<<< Exiting moveRight(dt=" .. tostring(dt) .. ")")
end

function Player:moveLeft(dt)
print(">>> Entering moveLeft(dt=" .. tostring(dt) .. ")")
  self.xv = self.xv + self.speed

print("moveLeft(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "")
print("moveLeft(dt=" .. tostring(dt) .. "): self.direction → " .. tostring(self.direction) .. "")
  self.direction = -1
  if self.direction == 1 then
    self.xv = 0
  end
print("<<< Exiting moveLeft(dt=" .. tostring(dt) .. ")")
end

function Player:jump(dt)
print(">>> Entering jump(dt=" .. tostring(dt) .. ")")
  if self.grounded == true then
    self.yv = self.yv - 300;
	print("jump(dt=" .. tostring(dt) .. "): self.yv → " .. tostring(self.yv) .. "")
  end
print("<<< Exiting jump(dt=" .. tostring(dt) .. ")")
end