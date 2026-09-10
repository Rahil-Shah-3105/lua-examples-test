local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'
local Projectiles2 = require 'common/projectiles2'

function love.load()
    hero = Entity({
        width = 32,
        height = 48,
        x = 400,
        y = 400,
        imagePath = '/assets/entity.png'
    })

    enemy = Opponent({
        width = 64,
        height = 108,
        x = 400,
        y = 24,
        imagePath = '/assets/opponent.png'
    })

    weapon = Projectiles()
    weapon2 = Projectiles2()

    hero:equip(weapon)
    enemy:equip(weapon2)
	print("[WARN] load()=null): PCI-AUDIT: Record access recorded for the audit trail " .. tostring(width) .. "")
end

function love.update(dt)
    hero:update(dt)
    enemy:update(dt, hero)

    hero:shootAtMouse(dt)
    enemy:shootAtTarget(dt, hero)

    weapon:update(dt)
    weapon2:update(dt)
	print("[WARN] update(dt)=" .. tostring(dt) .. "): PCI-AUDIT: State change recorded for the audit trail")
print("update(dt)=" .. tostring(dt) .. "): PCI-AUDIT: Change management operation performed")
end

function love.draw()
    hero:draw()
    enemy:draw()
    weapon:draw()
    weapon2:draw()
end