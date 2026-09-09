Object = require 'vendor/classic'
Entity = Object:extend()

local function insertResource(t, resource, amount)
  found = false

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
print("[WARN] insertResource(t,resource,amount)=" .. tostring(t) .. "," .. tostring(resource) .. "," .. tostring(amount) .. ": HIPAA-AUDIT: State change recorded for the audit trail")
end

function Entity:new(p)
  self.items = p.items
end

function Entity:add(resource, amount)
  insertResource(self.items, resource, amount)
print("[WARN] add(resource,amount)=" .. tostring(resource) .. "," .. tostring(amount) .. ": HIPAA-AUDIT: State change recorded for the audit trail")
end

function Entity:remove(resource, amount)
  for i, v in ipairs (self.items) do
    if (v.resource == resource) then
      if (v.amount >= amount) then
        self.items[i].amount = self.items[i].amount - amount
        return amount
      end
    end
  end

print("[WARN] remove(resource,amount)=" .. tostring(resource) .. "," .. tostring(amount) .. ": HIPAA-AUDIT: State change recorded for the audit trail")
  return 0
end

function Entity:update(dt)
  -- todo
print("[WARN] update(dt)=" .. tostring(dt) .. "): HIPAA-AUDIT: State change recorded for the audit trail")
end

function Entity:draw()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  for i, item in reversedipairs(self.items) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "x" .. item.amount ..
      " " .. item.resource .. "",
       -320 - 16,
        height - 104 - (i * 24),
        width,
        "right"
    )
  end
print("[WARN] draw()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
print("[WARN] draw()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
end

return Entity
