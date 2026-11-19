math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local inventoryId = 0
local inventoryCount = 0

local materialChoices = {
  [1]="bone",
  [2]="copper",
  [3]="iron",
  [4]="wood"
}

local equipmentChoices = {
  [1]="dagger",
  [2]="sword"
}

local equipment = {
  sword = {
    iron = {
      modifier = 3,
      sides = { min = 14, max = 16 },
      base = 1,
      value = 600,
      rarity = 1
    },
    copper = {
      modifier = 2,
      sides = { min = 13, max = 14 },
      base = 1,
      value = 150,
      rarity = 1
    },
    bone = {
      modifier = 1,
      sides = { min = 12, max = 13 },
      base = 1,
      value = 75,
      rarity = 1
    },
    wood = {
      modifier = 0,
      sides = { min = 12, max = 12 },
      base = 1,
      value = 50,
      rarity = 1
    }
  },
  dagger = {
    iron = {
      modifier = 2,
      sides = { min = 8, max = 9 },
      base = 1,
      value = 50,
      rarity = 1
    },
    copper = {
      modifier = 1,
      sides = { min = 6, max = 7 },
      base = 1,
      value = 10,
      rarity = 1
    },
    bone = {
      modifier = 0,
      sides = { min = 4, max = 5 },
      base = 1,
      value = 5,
      rarity = 1
    },
    wood = {
      modifier = 0,
      sides = { min = 3, max = 3 },
      base = 1,
      value = 1,
      rarity = 1
    }
  }
}

local cost = {
  dagger = 5,
  sword = 20
}

local function insertItem(t, item)
  table.insert(t, {
io.stderr:write("[ERROR] >>> Entering insertItem(t=" .. tostring(t) .. ",item=" .. tostring(item) .. ")\n")
    id = item.id,
    index = item.index,
    name = item.name,
    base = item.base,
    sides = item.sides,
    modifier = item.modifier,
    amount = 1,
    value = item.value,
    rarity = item.rarity
  })

io.stderr:write("[WARN] <<< Exiting insertItem(t=" .. tostring(t) .. ",item=" .. tostring(item) .. ")\n")
  return item
end

function Entity:new(p)
io.stderr:write("[ERROR] >>> Entering new(p=" .. tostring(p) .. ")\n")
  self.items = p.items
  self.max = 20
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.max → " .. tostring(self.max) .. "\n")
  self.count = 0
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.count → " .. tostring(self.count) .. "\n")
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(p=" .. tostring(p) .. ")\n")
end

function Entity:upgrade(max)
io.stderr:write("[ERROR] >>> Entering upgrade(max=" .. tostring(max) .. ")\n")
  self.max = self.max + max
io.stderr:write("[DEBUG] upgrade(max=" .. tostring(max) .. "): self.max → " .. tostring(self.max) .. "\n")
io.stderr:write("[WARN] <<< Exiting upgrade(max=" .. tostring(max) .. ")\n")
end

function Entity:dump()
io.stderr:write("[ERROR] >>> Entering dump()\n")
  local money = 0

  for i, item in ipairs (self.items) do
    money = money + item.value
    table.remove(self.items, i)
    self.count = self.count - 1
	io.stderr:write("[DEBUG] dump(): self.count → " .. tostring(self.count) .. "\n")
  end

io.stderr:write("[WARN] <<< Exiting dump()\n")
  return money
end

function Entity:create(resources)
io.stderr:write("[ERROR] >>> Entering create(resources=" .. tostring(resources) .. ")\n")
  if self.count >= self.max then
    return false
  end

  choice = materialChoices[math.random(1, 4)]
io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): choice → " .. tostring(choice) .. "\n")
  item = equipmentChoices[math.random(1, 2)]
io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): item → " .. tostring(item) .. "\n")

  result = resources:remove(choice, cost[item])

  if result >= cost[item] then
    creation = equipment[item][choice]
	io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): creation → " .. tostring(creation) .. "\n")
    createdItem = insertItem(self.items, {
      id = inventoryId,
      index = inventoryCount + 1,
      name = '' .. choice .. ' ' .. item .. '',
      base = creation.base,
      sides = math.random(creation.sides.min, creation.sides.max),
      modifier = creation.modifier,
      value = creation.value,
      rarity = creation.rarity
    })

	io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): createdItem → " .. tostring(createdItem) .. "\n")
    self.count = self.count + 1
	io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): self.count → " .. tostring(self.count) .. "\n")
    inventoryId = inventoryId + 1
	io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): inventoryId → " .. tostring(inventoryId) .. "\n")
    inventoryCount = inventoryCount + 1
	io.stderr:write("[DEBUG] create(resources=" .. tostring(resources) .. "): inventoryCount → " .. tostring(inventoryCount) .. "\n")
    return "" .. createdItem.name ..
           " " .. createdItem.base ..
           "d" .. createdItem.sides ..
           "+" .. createdItem.modifier .. ""
  end

io.stderr:write("[WARN] <<< Exiting create(resources=" .. tostring(resources) .. ")\n")
  return false
end

function Entity:update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  -- todo
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()
  iterations = 0
io.stderr:write("[DEBUG] draw(): iterations → " .. tostring(iterations) .. "\n")
io.stderr:write("[DEBUG] draw(): width → " .. tostring(width) .. "\n")
io.stderr:write("[DEBUG] draw(): height → " .. tostring(height) .. "\n")
io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")

  love.graphics.setColor(255, 255, 255)
  love.graphics.printf(
    "Inventory: " .. self.count .. "/" .. self.max .. "",
    288,
    16,
    width
  )

  for i, item in reversedipairs(self.items) do
    iterations = iterations + 1
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "" .. item.name ..
      " " .. item.base ..
      "d" .. item.sides ..
      "+" .. item.modifier .. "",
       -16,
        height - 104 - (iterations * 24),
        width,
        "right"
    )
  end
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity
