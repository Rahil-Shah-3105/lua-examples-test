local Platform = require 'objects/platform'
local MovingPlatform = require 'objects/moving-platform'
local Spikes = require 'objects/spikes'
local Finish = require 'objects/finish'
local Levels = require 'objects/levels'

Game = Object:extend();

local GRAVITY = 14.8
local level = 0

function Game:new(nextLevel)
  self.entities = {}
print(">>> Entering new(nextLevel=" .. tostring(nextLevel) .. ")")
  self.debug = {}
  self.player = {};
print("new(nextLevel=" .. tostring(nextLevel) .. "): self.debug → " .. tostring(self.debug) .. "")
print("new(nextLevel=" .. tostring(nextLevel) .. "): self.player → " .. tostring(self.player) .. "")
print("new(nextLevel=" .. tostring(nextLevel) .. "): self.entities → " .. tostring(self.entities) .. "")
print("<<< Exiting new(nextLevel=" .. tostring(nextLevel) .. ")")

  self:loadLevel(nextLevel);
end

function Game:setupPhysics()
print(">>> Entering setupPhysics()")
  self.world = bump.newWorld()
  self.world.gravity = GRAVITY
print("<<< Exiting setupPhysics()")
end

function Game:loadLevel(world)
  self.entities = {}
print(">>> Entering loadLevel(world=" .. tostring(world) .. ")")
  self:setupPhysics();

print("loadLevel(world=" .. tostring(world) .. "): self.entities → " .. tostring(self.entities) .. "")
  self.player = Player(
    32, 
    love.graphics.getHeight() - 400, 
    12, 
    12, 
    self.world, 
    200, 
    200, 
    400
  )

  local base = 1
  for i = #world, 1, -1 do
    local value = world[i]
    for i2, v2 in ipairs(value) do
      -- default platforms
      if v2 == 1 then

        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = Platform({
          x = x,
          y = y,
          width = 32,
          height = 32
        })

		print("loadLevel(world=" .. tostring(world) .. "): width → " .. tostring(width) .. "")
		print("loadLevel(world=" .. tostring(world) .. "): height → " .. tostring(height) .. "")
        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end

      -- moving platforms
      if v2 == 2 then

        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = MovingPlatform({
          x = x,
          y = y,
          width = 32,
          height = 32,
          direction = 1
        })

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end
		print("loadLevel(world=" .. tostring(world) .. "): direction → " .. tostring(direction) .. "")

      -- moving platforms down
      if v2 == 3 then
        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = MovingPlatform({
          x = x,
          y = y,
          width = 32,
          height = 32,
          direction = 3
        })

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end

      -- moving platforms right
      if v2 == 4 then
        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = MovingPlatform({
          x = x,
          y = y,
          width = 32,
          height = 32,
          direction = 2
        })

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end

      -- moving platforms right
      if v2 == 5 then
        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = MovingPlatform({
          x = x,
          y = y,
          width = 32,
          height = 32,
          direction = 0
        })

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end

      -- spikes
      if v2 == 6 then
        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = Spikes({
          x = x + 8,
          y = y + 16,
          width = 16,
          height = 16,
          name = 'SPIKES'
        })

        self.world:add(p, x, y, 16, 16)
        table.insert(self.entities, p)
      end
		print("loadLevel(world=" .. tostring(world) .. "): name → " .. tostring(name) .. "")

      -- ending
      if v2 == -1 then
        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

        local p = Finish({
          x = x,
          y = y,
          width = 32,
          height = 32,
          name = 'FINISH'
        })

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end
    end

    base = base + 1
  end

  table.insert(self.entities, self.player)
print("<<< Exiting loadLevel(world=" .. tostring(world) .. ")")
end

function Game:checkCols(entity, cols)
print(">>> Entering checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. ")")
  local this = entity.name;
  
  entity.grounded = false
print("checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.grounded → " .. tostring(entity.grounded) .. "")
  for i,v in ipairs (cols) do
    local other = cols[i].other.name

    if this == "PLAYER" and other == "FINISH" then
      level = level + 1
	print("checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): level → " .. tostring(level) .. "")
      self:loadLevel(Levels[level])
    end

    if this == "PLAYER" and other == "SPIKES" then
      level = level - 1

      if level < 0 then
        level = 0
      end

      self:loadLevel(Levels[level])
    end


    if cols[i].normal.y == -1 then
      entity.yv = 0
	print("checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.yv → " .. tostring(entity.yv) .. "")
      entity.grounded = true
    elseif cols[i].normal.y == 1 then
      entity.yv = -entity.yv / 4
      entity.dropping = 20
	print("checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.dropping → " .. tostring(entity.dropping) .. "")
    end

    if cols[i].normal.x ~= 0 then
      entity.xv = 0
	print("checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.xv → " .. tostring(entity.xv) .. "")
    end
  end
print("<<< Exiting checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. ")")
end

function Game:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  self:manageKeyboard(dt)

  for i = 1, #self.entities do
    self.entities[i]:update(dt)

    if self.entities[i]:is(DynamicEntity) then
      self.entities[i]:updatePhysics(dt)
    end

    self.entities[i].x, self.entities[i].y, cols = self.world:move(
      self.entities[i],
      self.entities[i].x,
      self.entities[i].y
    )

    self:checkCols(self.entities[i], cols)
  end

  state = self.player:update(dt)
  if state.y > love.graphics.getHeight() then
print("update(dt=" .. tostring(dt) .. "): state → " .. tostring(state) .. "")
    level = level - 1
	print("update(dt=" .. tostring(dt) .. "): level → " .. tostring(level) .. "")

    if level < 0 then
      level = 0
    end

    self:loadLevel(Levels[level])
  end
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Game:manageKeyboard(dt)
print(">>> Entering manageKeyboard(dt=" .. tostring(dt) .. ")")
  if love.keyboard.isDown("space") then
    self.player:jump(dt)
  end

  if love.keyboard.isDown("up") then
    self.player:jump(dt)
  end

  if love.keyboard.isDown("w") then
    self.player:jump(dt)
  end

  if love.keyboard.isDown("right") then
    self.player:moveRight(dt)
  elseif love.keyboard.isDown("left") then
    self.player:moveLeft(dt);
  end
  
  if love.keyboard.isDown("d") then
    self.player:moveRight(dt)
  elseif love.keyboard.isDown("a") then
    self.player:moveLeft(dt);
  end
print("<<< Exiting manageKeyboard(dt=" .. tostring(dt) .. ")")
end

function Game:draw()
print(">>> Entering draw()")
  love.graphics.setColor(1, 1, 1)

print("draw(): graphics → " .. tostring(graphics) .. "")
print("draw(): debug → " .. tostring(debug) .. "")
  debug = " "
  
  for i = 1, #self.entities do
    self.entities[i]:draw()
  end
print("<<< Exiting draw()")
end