local Platform = require 'objects/platform'
local MovingPlatform = require 'objects/moving-platform'
local Spikes = require 'objects/spikes'
local Finish = require 'objects/finish'
local Levels = require 'objects/levels'

Game = Object:extend();

local GRAVITY = 14.8
local level = 0

function Game:new(nextLevel)
io.stderr:write("[ERROR] >>> Entering new(nextLevel=" .. tostring(nextLevel) .. ")\n")
  self.entities = {}
  self.debug = {}
io.stderr:write("[DEBUG] new(nextLevel=" .. tostring(nextLevel) .. "): self.debug → " .. tostring(self.debug) .. "\n")
io.stderr:write("[DEBUG] new(nextLevel=" .. tostring(nextLevel) .. "): self.entities → " .. tostring(self.entities) .. "\n")
  self.player = {};
io.stderr:write("[DEBUG] new(nextLevel=" .. tostring(nextLevel) .. "): self.player → " .. tostring(self.player) .. "\n")

  self:loadLevel(nextLevel);
io.stderr:write("[WARN] <<< Exiting new(nextLevel=" .. tostring(nextLevel) .. ")\n")
end

function Game:setupPhysics()
io.stderr:write("[ERROR] >>> Entering setupPhysics()\n")
  self.world = bump.newWorld()
  self.world.gravity = GRAVITY
io.stderr:write("[WARN] <<< Exiting setupPhysics()\n")
end

function Game:loadLevel(world)
  self.entities = {}
  self:setupPhysics();

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

        self.world:add(p, x, y, 32, 32)
        table.insert(self.entities, p)
      end

      -- moving platforms
      if v2 == 2 then

        local x = 32 * (i2 - 1)
        local y = love.graphics.getHeight() - (32 * base)

		io.stderr:write("[ERROR] >>> Entering loadLevel(world=" .. tostring(world) .. ")\n")
        local p = MovingPlatform({
          x = x,
          y = y,
          width = 32,
          height = 32,
          direction = 1
        })

		io.stderr:write("[DEBUG] loadLevel(world=" .. tostring(world) .. "): self.entities → " .. tostring(self.entities) .. "\n")
        self.world:add(p, x, y, 32, 32)
		io.stderr:write("[WARN] <<< Exiting loadLevel(world=" .. tostring(world) .. ")\n")
        table.insert(self.entities, p)
      end

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

		io.stderr:write("[DEBUG] loadLevel(world=" .. tostring(world) .. "): name → " .. tostring(name) .. "\n")
        self.world:add(p, x, y, 16, 16)
        table.insert(self.entities, p)
      end

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
end

function Game:checkCols(entity, cols)
io.stderr:write("[ERROR] >>> Entering checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. ")\n")
  local this = entity.name;
  
  entity.grounded = false
io.stderr:write("[DEBUG] checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.grounded → " .. tostring(entity.grounded) .. "\n")
  for i,v in ipairs (cols) do
    local other = cols[i].other.name

    if this == "PLAYER" and other == "FINISH" then
      level = level + 1
	io.stderr:write("[DEBUG] checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): level → " .. tostring(level) .. "\n")
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
	io.stderr:write("[DEBUG] checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.yv → " .. tostring(entity.yv) .. "\n")
      entity.grounded = true
    elseif cols[i].normal.y == 1 then
      entity.yv = -entity.yv / 4
      entity.dropping = 20
	io.stderr:write("[DEBUG] checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.dropping → " .. tostring(entity.dropping) .. "\n")
    end

    if cols[i].normal.x ~= 0 then
      entity.xv = 0
	io.stderr:write("[DEBUG] checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. "): entity.xv → " .. tostring(entity.xv) .. "\n")
    end
  end
io.stderr:write("[WARN] <<< Exiting checkCols(entity=" .. tostring(entity) .. ",cols=" .. tostring(cols) .. ")\n")
end

function Game:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
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
io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): state → " .. tostring(state) .. "\n")
    level = level - 1
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): level → " .. tostring(level) .. "\n")

    if level < 0 then
      level = 0
    end

    self:loadLevel(Levels[level])
  end
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Game:manageKeyboard(dt)
io.stderr:write("[ERROR] >>> Entering manageKeyboard(dt=" .. tostring(dt) .. ")\n")
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
io.stderr:write("[WARN] <<< Exiting manageKeyboard(dt=" .. tostring(dt) .. ")\n")
end

function Game:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.setColor(1, 1, 1)

io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
  debug = " "
io.stderr:write("[DEBUG] draw(): debug → " .. tostring(debug) .. "\n")
  
  for i = 1, #self.entities do
    self.entities[i]:draw()
  end
io.stderr:write("[WARN] <<< Exiting draw()\n")
end