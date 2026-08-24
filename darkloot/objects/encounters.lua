Object = require 'vendor/classic'
Entity = Object:extend()

local BULLET_SPEED = 64

-- shares with world.lua
local lineUnit = 48
local lineAnimationUnit = 1 / lineUnit
local extension = lineUnit * 8
local lineLength = lineUnit + extension
local largestY = 0
local rightOffset = 336
local rightIncrement = 240
local topOffset = 16

local function newAnimation(image, width, height, duration)
  local animation = {}
print(">>> Entering newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")")
  animation.spriteSheet = image;
  animation.quads = {};
print("newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.quads → " .. tostring(animation.quads) .. "")
print("newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.spriteSheet → " .. tostring(animation.spriteSheet) .. "")

  local y = 0
  local x = 0

  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      table.insert(
        animation.quads, 
        love.graphics.newQuad(x, y, width, height, 
        image:getDimensions()))
    end
  end

  animation.duration = duration or 1
print("newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.duration → " .. tostring(animation.duration) .. "")
print("newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.current → " .. tostring(animation.current) .. "")
  animation.current = 0

print("<<< Exiting newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")")
  return animation
end

function Entity:new()
  self.mounted = {}
print(">>> Entering new()")
print("new(): self.animation → " .. tostring(self.animation) .. "")

  self.animation = {
    gatherer = newAnimation(
      love.graphics.newImage("assets/gatherer.png"),
      28, 
      32, 
      1
    ),
    blacksmith = newAnimation(
      love.graphics.newImage("assets/blacksmith.png"),
      30, 
      32, 
      1
    ),
    merchant = newAnimation(
      love.graphics.newImage("assets/merchant.png"),
      33, 
      32, 
      1
    )
  }
print("new(): self.mounted → " .. tostring(self.mounted) .. "")
end

function Entity:showEncounter(character, offset)
print(">>> Entering showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. ")")
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

print("showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): height → " .. tostring(height) .. "")
print("showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): width → " .. tostring(width) .. "")
  local sx = width - rightOffset - offset
  local sy = lineLength

  local tx = width - rightOffset - offset
  local ty = -48

  local angle = math.atan2(( ty - sy ), (tx - sx))

  local projectileProperties = {
    character = character,
    x = sx,
    y = sy,
    angle = angle,
    hex = 0
  }
print("showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): hex → " .. tostring(hex) .. "")

  table.insert(self.mounted, projectileProperties)
print("<<< Exiting showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. ")")
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  for i,v in pairs(self.animation) do
    v.current = v.current + dt
	print("update(dt=" .. tostring(dt) .. "): v.current → " .. tostring(v.current) .. "")

    if v.current >= v.duration then
      v.current = v.current - v.duration
    end
  end

  for i,v in pairs(self.mounted) do
      local dx = BULLET_SPEED * math.cos(v.angle)
      local dy = BULLET_SPEED * math.sin(v.angle)
      v.x = v.x + (dx * dt)
      v.y = v.y + (dy * dt)

      v.hex = v.hex + (1 / 86)
      
      if v.x > love.graphics.getWidth() or
         v.y > love.graphics.getHeight() or
         v.x < -48 or
         v.y < -48 then
        table.remove(self.mounted, i)
      end
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  for i,v in pairs(self.mounted) do

    love.graphics.setColor(v.hex, v.hex, v.hex)

	print("draw(): graphics → " .. tostring(graphics) .. "")
    local spriteNum = math.floor(
      self.animation[v.character].current 
      / self.animation[v.character].duration
      * #self.animation[v.character].quads
    ) + 1

    love.graphics.draw(
      self.animation[v.character].spriteSheet,
      self.animation[v.character].quads[spriteNum],
      v.x,
      v.y,
      0,
      1
    )
  end
print("<<< Exiting draw()")
end

return Entity