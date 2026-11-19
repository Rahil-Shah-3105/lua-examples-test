Object = require 'vendor/classic'
Entity = Object:extend()

local function insertResource(t, resource, amount)
  found = false
io.stderr:write("[ERROR] >>> Entering insertResource(t=" .. tostring(t) .. ",resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")

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
io.stderr:write("[WARN] <<< Exiting insertResource(t=" .. tostring(t) .. ",resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")
end

function Entity:new(p)
io.stderr:write("[ERROR] >>> Entering new(p=" .. tostring(p) .. ")\n")
  self.items = p.items
io.stderr:write("[DEBUG] new(p=" .. tostring(p) .. "): self.items → " .. tostring(self.items) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(p=" .. tostring(p) .. ")\n")
end

function Entity:add(resource, amount)
io.stderr:write("[ERROR] >>> Entering add(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")
  insertResource(self.items, resource, amount)
io.stderr:write("[WARN] <<< Exiting add(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")
end

function Entity:remove(resource, amount)
io.stderr:write("[ERROR] >>> Entering remove(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")
  for i, v in ipairs (self.items) do
    if (v.resource == resource) then
      if (v.amount >= amount) then
        self.items[i].amount = self.items[i].amount - amount
        return amount
      end
    end
  end

io.stderr:write("[WARN] <<< Exiting remove(resource=" .. tostring(resource) .. ",amount=" .. tostring(amount) .. ")\n")
  return 0
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

io.stderr:write("[DEBUG] draw(): width → " .. tostring(width) .. "\n")
io.stderr:write("[DEBUG] draw(): height → " .. tostring(height) .. "\n")
  for i, item in reversedipairs(self.items) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "x" .. item.amount ..
	io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
      " " .. item.resource .. "",
       -320 - 16,
        height - 104 - (i * 24),
        width,
        "right"
    )
  end
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Entity
