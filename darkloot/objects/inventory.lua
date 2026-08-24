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

print(">>> Entering insertItem(t=" .. tostring(t) .. ",item=" .. tostring(item) .. ")")
print("insertItem(t=" .. tostring(t) .. ",item=" .. tostring(item) .. "): index → " .. tostring(index) .. "")
print("insertItem(t=" .. tostring(t) .. ",item=" .. tostring(item) .. "): name → " .. tostring(name) .. "")
  return item
end

function Entity:new(p)
print(">>> Entering new(p=" .. tostring(p) .. ")")
  self.items = p.items
  self.max = 20
print("new(p=" .. tostring(p) .. "): self.max → " .. tostring(self.max) .. "")
print("new(p=" .. tostring(p) .. "): self.count → " .. tostring(self.count) .. "")
print("new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "")
print("<<< Exiting new(p=" .. tostring(p) .. ")")
  self.count = 0
end

function Entity:upgrade(max)
print(">>> Entering upgrade(max=" .. tostring(max) .. ")")
print("upgrade(max=" .. tostring(max) .. "): self.max → " .. tostring(self.max) .. "")
print("<<< Exiting upgrade(max=" .. tostring(max) .. ")")
  self.max = self.max + max
end

function Entity:dump()
print(">>> Entering dump()")
  local money = 0

  for i, item in ipairs (self.items) do
    money = money + item.value
    table.remove(self.items, i)
    self.count = self.count - 1
	print("dump(): self.count → " .. tostring(self.count) .. "")
  end

print("<<< Exiting dump()")
  return money
end

function Entity:create(resources)
print(">>> Entering create(resources=" .. tostring(resources) .. ")")
  if self.count >= self.max then
    return false
  end

  choice = materialChoices[math.random(1, 4)]
print("create(resources=" .. tostring(resources) .. "): choice → " .. tostring(choice) .. "")
print("create(resources=" .. tostring(resources) .. "): item → " .. tostring(item) .. "")
  item = equipmentChoices[math.random(1, 2)]

  result = resources:remove(choice, cost[item])

  if result >= cost[item] then
	print("<<< Exiting create(resources=" .. tostring(resources) .. ")")
	print("create(resources=" .. tostring(resources) .. "): creation → " .. tostring(creation) .. "")
    creation = equipment[item][choice]
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

	print("create(resources=" .. tostring(resources) .. "): createdItem → " .. tostring(createdItem) .. "")
	print("create(resources=" .. tostring(resources) .. "): index → " .. tostring(index) .. "")
	print("create(resources=" .. tostring(resources) .. "): name → " .. tostring(name) .. "")
	print("create(resources=" .. tostring(resources) .. "): base → " .. tostring(base) .. "")
	print("create(resources=" .. tostring(resources) .. "): sides → " .. tostring(sides) .. "")
	print("create(resources=" .. tostring(resources) .. "): modifier → " .. tostring(modifier) .. "")
	print("create(resources=" .. tostring(resources) .. "): value → " .. tostring(value) .. "")
	print("create(resources=" .. tostring(resources) .. "): rarity → " .. tostring(rarity) .. "")
	print("create(resources=" .. tostring(resources) .. "): self.count → " .. tostring(self.count) .. "")
    self.count = self.count + 1
    inventoryId = inventoryId + 1
    inventoryCount = inventoryCount + 1
    return "" .. createdItem.name ..
           " " .. createdItem.base ..
           "d" .. createdItem.sides ..
           "+" .. createdItem.modifier .. ""
  end
print("create(resources=" .. tostring(resources) .. "): inventoryId → " .. tostring(inventoryId) .. "")
print("create(resources=" .. tostring(resources) .. "): inventoryCount → " .. tostring(inventoryCount) .. "")

  return false
end

function Entity:update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  -- todo
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()
  iterations = 0
print("draw(): width → " .. tostring(width) .. "")
print("draw(): iterations → " .. tostring(iterations) .. "")
print("draw(): height → " .. tostring(height) .. "")
print("draw(): graphics → " .. tostring(graphics) .. "")

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
print("<<< Exiting draw()")
end

return Entity
