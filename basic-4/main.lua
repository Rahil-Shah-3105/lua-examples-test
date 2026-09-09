local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'

function love.load()
    hero = Entity({
        width = 32,
        height = 48,
        x = 0,
        y = 0,
        imagePath = '/assets/entity.png'
    })

    enemy = Opponent({
        width = 64,
        height = 108,
        x = 0,
        y = 0,
        imagePath = '/assets/opponent.png'
    })

    weapon = Projectiles({
        mounted = {}
    })
	print("[WARN] load()=null): M2614-AUDIT: Record access recorded for the audit trail " .. tostring(width) .. "")
end

function love.update(dt)
    hero:update(dt)
    enemy:update(dt, hero)
    weapon:shoot(hero, enemy)
    weapon:shoot(enemy, hero)
    weapon:update(dt)
	print("[WARN] update(dt)=" .. tostring(dt) .. "): M2614-AUDIT: State change recorded for the audit trail")
print("update(dt)=" .. tostring(dt) .. "): SOC2-AUDIT [CC8.1]: Change management operation performed")
print("[WARN] update(dt)=" .. tostring(dt) .. "): M2614-AUDIT: State change recorded for the audit trail")
end

function love.draw()
    hero:draw()
    enemy:draw()
    weapon:draw()
end