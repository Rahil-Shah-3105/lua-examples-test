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
io.stderr:write("[ERROR] >>> Entering newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")\n")
  animation.spriteSheet = image;
io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.spriteSheet → " .. tostring(animation.spriteSheet) .. "\n")
  animation.quads = {};
io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.quads → " .. tostring(animation.quads) .. "\n")

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
io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.duration → " .. tostring(animation.duration) .. "\n")
  animation.current = 0
io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.current → " .. tostring(animation.current) .. "\n")

io.stderr:write("[WARN] <<< Exiting newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")\n")
  return animation
end

function Entity:new()
io.stderr:write("[ERROR] >>> Entering new()\n")
  self.mounted = {}

io.stderr:write("[DEBUG] new(): self.mounted → " .. tostring(self.mounted) .. "\n")
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
io.stderr:write("[DEBUG] new(): self.animation → " .. tostring(self.animation) .. "\n")
io.stderr:write("[DEBUG] new(): gatherer → " .. tostring(gatherer) .. "\n")
io.stderr:write("[WARN] <<< Exiting new()\n")
end

function Entity:showEncounter(character, offset)
io.stderr:write("[ERROR] >>> Entering showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. ")\n")
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

io.stderr:write("[DEBUG] showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): height → " .. tostring(height) .. "\n")
io.stderr:write("[DEBUG] showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): width → " .. tostring(width) .. "\n")
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
io.stderr:write("[DEBUG] showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. "): hex → " .. tostring(hex) .. "\n")

  table.insert(self.mounted, projectileProperties)
io.stderr:write("[WARN] <<< Exiting showEncounter(character=" .. tostring(character) .. ",offset=" .. tostring(offset) .. ")\n")
end

function Entity:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  for i,v in pairs(self.animation) do
    v.current = v.current + dt
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): v.current → " .. tostring(v.current) .. "\n")

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
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  for i,v in pairs(self.mounted) do

    love.graphics.setColor(v.hex, v.hex, v.hex)

	io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
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
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity