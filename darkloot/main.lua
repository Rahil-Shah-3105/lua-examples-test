math.randomseed(os.time())

local Activity = require 'objects/activity'
local Resources = require 'objects/resources'
local Inventory = require 'objects/inventory';
local Player = require 'objects/player';
local World = require 'objects/world';
local Encounters = require 'objects/encounters';

local elapsed = 0
local duration = 0.11

local function upgradeEntity(entity)
  entity.exp = entity.exp + 50
io.stderr:write("[ERROR] >>> Entering upgradeEntity(entity=" .. tostring(entity) .. ")\n")

io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.exp → " .. tostring(entity.exp) .. "\n")
  -- level up
  if entity.exp >= entity.nextExp then
    entity.nextExp = entity.nextExp * 2
	io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.nextExp → " .. tostring(entity.nextExp) .. "\n")
    entity.level = entity.level + 1
	io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.level → " .. tostring(entity.level) .. "\n")
    entity.rate = entity.rate - 20
	io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.rate → " .. tostring(entity.rate) .. "\n")
    entity.cost = entity.cost + 25
	io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.cost → " .. tostring(entity.cost) .. "\n")
    entity.value = entity.value + 5
	io.stderr:write("[DEBUG] upgradeEntity(entity=" .. tostring(entity) .. "): entity.value → " .. tostring(entity.value) .. "\n")
    return true
  end

io.stderr:write("[WARN] <<< Exiting upgradeEntity(entity=" .. tostring(entity) .. ")\n")
  return false
end

local function drawCharacter(c, name)
  love.graphics.setFont(font)
  love.graphics.draw(c.image, c.coords.x, height - c.coords.y)
  love.graphics.printf(c.name, c.coords.x + 60, height - c.coords.y, width)
  love.graphics.setFont(monoFont)
  love.graphics.printf(
    "LVL  " .. c.level .. "",
    c.coords.x + 60,
    height + 24 - c.coords.y,
    width
io.stderr:write("[ERROR] >>> Entering drawCharacter(c=" .. tostring(c) .. ",name=" .. tostring(name) .. ")\n")
  )
  love.graphics.printf(
    "EXP  " .. c.exp .. "",
    c.coords.x + 60,
    height + 36 - c.coords.y,
    width
  )
  love.graphics.printf(
    "COST " .. c.cost .. "g",
    c.coords.x + 60,
    height + 48 - c.coords.y,
    width
  )
io.stderr:write("[WARN] <<< Exiting drawCharacter(c=" .. tostring(c) .. ",name=" .. tostring(name) .. ")\n")
end

local function randomSelectResource()
  eventValue = math.random(1, 26)

io.stderr:write("[ERROR] >>> Entering randomSelectResource()\n")
  local result = ({
    [1]="copper",
    [2]="copper",
    [3]="copper",
    [4]="copper",
    [5]="copper",
    [6]="bone",
    [7]="bone",
    [8]="bone",
    [9]="bone",
    [10]="bone",
    [11]="bone",
    [12]="bone",
    [13]="bone",
    [14]="bone",
    [15]="bone",
    [16]="wood",
    [17]="wood",
    [18]="wood",
    [19]="wood",
    [20]="wood",
    [21]="wood",
    [22]="wood",
    [23]="wood",
    [24]="wood",
    [25]="wood",
    [26]="iron"
  })[eventValue];

io.stderr:write("[WARN] <<< Exiting randomSelectResource()\n")
  return result
end

local function merchantEvent(activity, encounters, viewer)
  activity:add("Merchant: I came to bring your stock to the king.")
  sellEvent = viewer:sell(inventory, cMerchant.value)

io.stderr:write("[ERROR] >>> Entering merchantEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",viewer=" .. tostring(viewer) .. ")\n")
  if sellEvent == false then
    activity:add("Merchant: I came to bring your stock to the king, but you have nothing for sale.")
  end
  if sellEvent == true then
    activity:add("Merchant: I came to bring your stock to the king, thank you for selling me your goods.")
  end

  encounters:showEncounter('merchant', 135)
io.stderr:write("[WARN] <<< Exiting merchantEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",viewer=" .. tostring(viewer) .. ")\n")
end

local function blacksmithEvent(activity, encounters, inventory)
  activity:add("Blacksmith: I tried to create something.")
  createEvent = inventory:create(resources)
  if createEvent == false then
io.stderr:write("[ERROR] >>> Entering blacksmithEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",inventory=" .. tostring(inventory) .. ")\n")
    activity:add("Blacksmith: I failed to create an item.")
  end
  if createEvent ~= false then
    activity:add("Blacksmith: I created a " .. createEvent .. ".")
  end

  encounters:showEncounter('blacksmith', 86)
io.stderr:write("[WARN] <<< Exiting blacksmithEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",inventory=" .. tostring(inventory) .. ")\n")
end

local function gathererEvent(activity, encounters, resources)
  foundResource = randomSelectResource()
  resources:add(foundResource, 1)
  activity:add("Gatherer: I found a valuable resource, I found " .. foundResource .. ".")
  encounters:showEncounter('gatherer', 38)
io.stderr:write("[ERROR] >>> Entering gathererEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",resources=" .. tostring(resources) .. ")\n")
io.stderr:write("[WARN] <<< Exiting gathererEvent(activity=" .. tostring(activity) .. ",encounters=" .. tostring(encounters) .. ",resources=" .. tostring(resources) .. ")\n")
end

function love.mousepressed(mx, my, button)
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  if button == 1
  and mx >= cBlacksmith.coords.x and mx < cBlacksmith.coords.x + cBlacksmith.image:getWidth()
  and my >= cBlacksmith.coords.y and my < height - cBlacksmith.coords.y + cBlacksmith.image:getHeight() then
    result = viewer:spend(cBlacksmith.cost)
    if result <= 0 then
      return false
    end

    upgradeEntity(cBlacksmith)
    return true
  end

  if button == 1
  and mx >= cMerchant.coords.x and mx < cMerchant.coords.x + cMerchant.image:getWidth()
  and my >= cMerchant.coords.y and my < height - cMerchant.coords.y + cMerchant.image:getHeight() then
    result = viewer:spend(cMerchant.cost)
    if result <= 0 then
      return false
    end

    upgradeEntity(cMerchant)
    return true
  end

  if button == 1
  and mx >= cGatherer.coords.x and mx < cGatherer.coords.x + cGatherer.image:getWidth()
  and my >= cGatherer.coords.y and my < height - cGatherer.coords.y + cGatherer.image:getHeight() then
    result = viewer:spend(cGatherer.cost)
    if result <= 0 then
      return false
    end

    upgradeEntity(cGatherer)
    return true
  end

  if button == 1
  and mx >= cCastle.coords.x and mx < cCastle.coords.x + cCastle.image:getWidth()
  and my >= cCastle.coords.y and my < height - cCastle.coords.y + cCastle.image:getHeight() then
	io.stderr:write("[ERROR] >>> Entering mousepressed(mx=" .. tostring(mx) .. ",my=" .. tostring(my) .. ",button=" .. tostring(button) .. ")\n")
	io.stderr:write("[DEBUG] mousepressed(mx=" .. tostring(mx) .. ",my=" .. tostring(my) .. ",button=" .. tostring(button) .. "): height → " .. tostring(height) .. "\n")
	io.stderr:write("[DEBUG] mousepressed(mx=" .. tostring(mx) .. ",my=" .. tostring(my) .. ",button=" .. tostring(button) .. "): width → " .. tostring(width) .. "\n")
    result = viewer:spend(cCastle.cost)
    if result <= 0 then
      return false
    end

    didLevel = upgradeEntity(cCastle)

    if cCastle.level == 3 and didLevel == true then
      inventory:upgrade(5)
      love.audio.stop(trackOne)
      love.audio.play(trackTwo)
    end

    if cCastle.level == 5 and didLevel == true then
      inventory:upgrade(5)
      love.audio.stop(trackTwo)
      love.audio.play(trackThree)
    end

    if cCastle.level == 8 and didLevel == true then
      inventory:upgrade(5)
      love.audio.stop(trackThree)
      love.audio.play(trackFour)
    end

	io.stderr:write("[WARN] <<< Exiting mousepressed(mx=" .. tostring(mx) .. ",my=" .. tostring(my) .. ",button=" .. tostring(button) .. ")\n")
    return true
  end
end

function love.load()
  trackOne = love.audio.newSource("track-1.mp3", "stream")
  trackOne:setLooping(true)
  love.audio.play(trackOne)

  trackTwo = love.audio.newSource("track-2.mp3", "stream")
  trackTwo:setLooping(true)

  trackThree = love.audio.newSource("track-3.mp3", "stream")
  trackThree:setLooping(true)

  trackFour = love.audio.newSource("track-4.mp3", "stream")
  trackFour:setLooping(true)

io.stderr:write("[DEBUG] load(): coords → " .. tostring(coords) .. "\n")
  io.stderr:write("[DEBUG] load(): value → " .. tostring(value) .. "\n")
io.stderr:write("[DEBUG] load(): cMerchant → " .. tostring(cMerchant) .. "\n")
  font = love.graphics.newFont("Masuria.ttf", 20)
  monoFont = love.graphics.newFont("SFMonoBold.ttf", 10)

io.stderr:write("[DEBUG] load(): cGatherer → " .. tostring(cGatherer) .. "\n")
  love.graphics.setFont(font)

io.stderr:write("[DEBUG] load(): cBlacksmith → " .. tostring(cBlacksmith) .. "\n")
  viewer = Player({ gold = 3000 })
  activity = Activity({ items = {} })
  resources = Resources({ items = {} })
  inventory = Inventory({ items = {} })
  world = World({ items = {} })
  encounters = Encounters()

io.stderr:write("[DEBUG] load(): resources → " .. tostring(resources) .. "\n")
io.stderr:write("[DEBUG] load(): inventory → " .. tostring(inventory) .. "\n")
io.stderr:write("[DEBUG] load(): activity → " .. tostring(activity) .. "\n")
io.stderr:write("[DEBUG] load(): viewer → " .. tostring(viewer) .. "\n")
io.stderr:write("[DEBUG] load(): graphics → " .. tostring(graphics) .. "\n")
  cBlacksmith = {
	io.stderr:write("[DEBUG] load(): encounters → " .. tostring(encounters) .. "\n")
    name = "Blacksmith's Guild",
    image = love.graphics.newImage("assets/upgrade-blacksmith.png"),
    coords = {
      x = 16 + (52 + 40 + 128) * 1,
      y = 68 + 16
    },
    level = 1,
    exp = 0,
    nextExp = 200,
    cost = 50,
    rate = 960,
    value = 0
  }
io.stderr:write("[DEBUG] load(): monoFont → " .. tostring(monoFont) .. "\n")
io.stderr:write("[ERROR] >>> Entering load()\n")

  cGatherer = {
    name = "Gatherer's Guild",
    image = love.graphics.newImage("assets/upgrade-gatherer.png"),
    coords = {
      x = 16,
      y = 68 + 16
    },
    level = 1,
    exp = 0,
    nextExp = 200,
    cost = 50,
    rate = 850,
    value = 0
  }
io.stderr:write("[DEBUG] load(): trackOne → " .. tostring(trackOne) .. "\n")
io.stderr:write("[DEBUG] load(): trackTwo → " .. tostring(trackTwo) .. "\n")

  cMerchant = {
    name = "Merchant's Guild",
    image = love.graphics.newImage("assets/upgrade-merchant.png"),
    coords = {
      x = 16 + ((52 + 40 + 128) * 2),
      y = 68 + 16
    },
    level = 1,
    exp = 0,
    nextExp = 200,
    cost = 50,
    rate = 995,
    value = 0
  }
io.stderr:write("[DEBUG] load(): trackThree → " .. tostring(trackThree) .. "\n")
io.stderr:write("[DEBUG] load(): trackFour → " .. tostring(trackFour) .. "\n")

  cCastle = {
    name = "Labor Camp",
    image = love.graphics.newImage("assets/upgrade-castle.png"),
    coords = {
      x = 16 + ((52 + 40 + 128) * 3),
      y = 68 + 16
    },
    level = 1,
    exp = 0,
    nextExp = 1000,
    cost = 100,
    rate = 999,
    value = 0
  }
io.stderr:write("[DEBUG] load(): font → " .. tostring(font) .. "\n")
end

function love.update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  activity:update(dt)
  resources:update(dt)
  inventory:update(dt)
  viewer:update(dt)
  world:update(dt)
  encounters:update(dt)

  elapsed = elapsed + dt + cCastle.level * 0.01
io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): elapsed → " .. tostring(elapsed) .. "\n")
  if elapsed < duration then
    return false
  end

  if elapsed >= duration then
    elapsed = elapsed - duration
  end

  eventValue = math.random(1, 1000)

io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): eventValue → " .. tostring(eventValue) .. "\n")
  if eventValue >= cMerchant.rate then
    return merchantEvent(activity, encounters, viewer)
  end

  if eventValue >= cBlacksmith.rate then
    return blacksmithEvent(activity, encounters, inventory)
  end

  if eventValue >= cGatherer.rate then
    return gathererEvent(activity, encounters, resources)
  end

io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
  return activity:add("Time has passed..")
end

function love.draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  love.graphics.setFont(font)
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

io.stderr:write("[DEBUG] draw(): height → " .. tostring(height) .. "\n")
io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
  encounters:draw()
  activity:draw()
  resources:draw()
  inventory:draw()
  viewer:draw()
  world:draw()
  encounters:draw()

  love.graphics.setColor(1, 1, 1)
  drawCharacter(cGatherer)
  drawCharacter(cBlacksmith)
  drawCharacter(cMerchant)
  drawCharacter(cCastle)
io.stderr:write("[WARN] <<< Exiting draw()\n")
io.stderr:write("[DEBUG] load(): cCastle → " .. tostring(cCastle) .. "\n")
io.stderr:write("[DEBUG] load(): coords → " .. tostring(coords) .. "\n")
io.stderr:write("[WARN] <<< Exiting load()\n")
end
