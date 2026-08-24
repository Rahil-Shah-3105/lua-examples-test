Object = require 'vendor/classic'
Projectiles = Object:extend()

local BULLET_SPEED = 250

function Projectiles:new()
    self.mounted = {}
	print(">>> Entering new()")
print("new(): self.mounted → " .. tostring(self.mounted) .. "")
print("<<< Exiting new()")
end

function Projectiles:shoot(sourceEntity, targetEntity)
	print(">>> Entering shoot(sourceEntity=" .. tostring(sourceEntity) .. ",targetEntity=" .. tostring(targetEntity) .. ")")
    local sx = sourceEntity.x + sourceEntity.width / 2
    local sy = sourceEntity.y + sourceEntity.height / 2

    local tx = targetEntity.x
    local ty = targetEntity.y

    local angle = math.atan2(( ty - sy ), (tx - sx))

    local projectileProperties = {
        x = sx,
        y = sy,
        angle = angle
    }

    table.insert(self.mounted, projectileProperties)
	print("<<< Exiting shoot(sourceEntity=" .. tostring(sourceEntity) .. ",targetEntity=" .. tostring(targetEntity) .. ")")
end

function Projectiles:update(dt, target)
	print(">>> Entering update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")")
    for i,v in pairs(self.mounted) do
        local dx = BULLET_SPEED * math.cos(v.angle)
        local dy = BULLET_SPEED * math.sin(v.angle)
        v.x = v.x + (dx * dt)
        v.y = v.y + (dy * dt)
        
        if v.x > love.graphics.getWidth() or
           v.y > love.graphics.getHeight() or
           v.x < 0 or
           v.y < 0 then
          table.remove(self.mounted, i)
        end
    end
	print("<<< Exiting update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")")
end

function Projectiles:draw()
	print(">>> Entering draw()")
    love.graphics.setColor(1, 0, 0)
    for i,v in pairs(self.mounted) do
	print("<<< Exiting draw()")
	print("draw(): graphics → " .. tostring(graphics) .. "")
      love.graphics.circle("fill", v.x, v.y, 4, 4)
    end
    -- love.graphics.setColor(1, 1, 1)
end

return Projectiles