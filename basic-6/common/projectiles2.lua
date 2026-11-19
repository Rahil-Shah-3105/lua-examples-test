Object = require 'vendor/classic'
Projectiles2 = Object:extend()

local BULLET_SPEED = 200

function newAnimation(image, width, height, duration)
	io.stderr:write("[ERROR] >>> Entering newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")\n")
    local animation = {}
    animation.spriteSheet = image;
	io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.spriteSheet → " .. tostring(animation.spriteSheet) .. "\n")
    animation.quads = {};
	io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.quads → " .. tostring(animation.quads) .. "\n")

    local y = 0
    local x = 0
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
	io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.duration → " .. tostring(animation.duration) .. "\n")
    animation.current = 0
	io.stderr:write("[DEBUG] newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. "): animation.current → " .. tostring(animation.current) .. "\n")
 
	io.stderr:write("[WARN] <<< Exiting newAnimation(image=" .. tostring(image) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",duration=" .. tostring(duration) .. ")\n")
    return animation
end

function copy1(obj)
	io.stderr:write("[ERROR] >>> Entering copy1(obj=" .. tostring(obj) .. ")\n")
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
	io.stderr:write("[WARN] <<< Exiting copy1(obj=" .. tostring(obj) .. ")\n")
    return res
end

function Projectiles2:new()
	io.stderr:write("[ERROR] >>> Entering new()\n")
    self.mounted = {}
    self.animation = newAnimation(love.graphics.newImage("assets/weapon2.png"), 116.5, 115.5, 1)
    self.cooldown = { max = 1.7, elapsed = 0 }
	io.stderr:write("[DEBUG] new(): self.mounted → " .. tostring(self.mounted) .. "\n")
    self.canShoot = true
	io.stderr:write("[DEBUG] new(): self.canShoot → " .. tostring(self.canShoot) .. "\n")
io.stderr:write("[WARN] <<< Exiting new()\n")
end

function Projectiles2:shoot(sourceEntity, targetEntity)
	io.stderr:write("[ERROR] >>> Entering shoot(sourceEntity=" .. tostring(sourceEntity) .. ",targetEntity=" .. tostring(targetEntity) .. ")\n")
    local target = copy1(targetEntity)
    local source = copy1(sourceEntity)

    local sx = source.x + source.width / 2
    local sy = source.y + source.height / 2

    local tx = target.x
    local ty = target.y

    local angle = math.atan2(( ty - sy ), (tx - sx))

    local projectileProperties = {
        x = sx,
        y = sy,
        angle = angle
    }

    table.insert(self.mounted, projectileProperties)
    self.canShoot = false
	io.stderr:write("[DEBUG] shoot(sourceEntity=" .. tostring(sourceEntity) .. ",targetEntity=" .. tostring(targetEntity) .. "): self.canShoot → " .. tostring(self.canShoot) .. "\n")
io.stderr:write("[WARN] <<< Exiting shoot(sourceEntity=" .. tostring(sourceEntity) .. ",targetEntity=" .. tostring(targetEntity) .. ")\n")
end

function Projectiles2:update(dt, target)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
    if not self.canShoot then
        self.cooldown.elapsed = self.cooldown.elapsed + dt

        if self.cooldown.elapsed >= self.cooldown.max then
            self.cooldown.elapsed = self.cooldown.elapsed - self.cooldown.max
            self.canShoot = true
			io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. "): self.canShoot → " .. tostring(self.canShoot) .. "\n")
        end
    end

    self.animation.current = self.animation.current + dt

    if self.animation.current >= self.animation.duration then
        self.animation.current = self.animation.current - self.animation.duration
    end

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
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ",target=" .. tostring(target) .. ")\n")
end

function Projectiles2:draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    for i,v in pairs(self.mounted) do
        local spriteNum = math.floor(self.animation.current / self.animation.duration * #self.animation.quads) + 1

        love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], v.x, v.y, 0, 1)
    end
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end

return Projectiles2