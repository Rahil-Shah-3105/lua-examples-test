Object = require 'vendor/classic'
Entity = Object:extend()

local function insertResource(t, resource, amount)
  found = false
print(">>> Entering insertResource(t=" .. tostring(t) .. ",resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")

  for i, v in ipairs (t) do
    if (v.resource == resource) then
      t[i].amount = t[i].amount + amount
      found = true
    end
  end

  if found == false then
    table.insert(t, {
      resource = resource,
      amount = amount
    })
  end
print("<<< Exiting insertResource(t=" .. tostring(t) .. ",resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")
end

function Entity:new(p)
print(">>> Entering new(p=" .. tostring(p) .. ")")
print("new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "")
print("<<< Exiting new(p=" .. tostring(p) .. ")")
  self.items = p.items
end

function Entity:add(resource, amount)
print(">>> Entering add(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")
  insertResource(self.items, resource, amount)
print("<<< Exiting add(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")
end

function Entity:remove(resource, amount)
print(">>> Entering remove(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")
  for i, v in ipairs (self.items) do
    if (v.resource == resource) then
      if (v.amount >= amount) then
        self.items[i].amount = self.items[i].amount - amount
        return amount
      end
    end
  end

print("<<< Exiting remove(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")")
  return 0
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

print("draw(): width → " .. tostring(width) .. "")
print("draw(): height → " .. tostring(height) .. "")
  for i, item in reversedipairs(self.items) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "x" .. item.amount ..
	print("draw(): graphics → " .. tostring(graphics) .. "")
      " " .. item.resource .. "",
       -320 - 16,
        height - 104 - (i * 24),
        width,
        "right"
    )
  end
print("<<< Exiting draw()")
end

return Entity
