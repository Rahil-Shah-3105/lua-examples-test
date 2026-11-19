local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'

function love.load()
	io.stderr:write("[ERROR] >>> Entering load()\n")
    hero = Entity({
        width = 32,
        height = 48,
        x = 0,
        y = 0,
        imagePath = '/assets/entity.png'
    })

	io.stderr:write("[DEBUG] load(): hero → " .. tostring(hero) .. "\n")
    enemy = Opponent({
        width = 64,
        height = 108,
        x = 0,
        y = 0,
        imagePath = '/assets/opponent.png'
    })

	io.stderr:write("[DEBUG] load(): enemy → " .. tostring(enemy) .. "\n")
    weapon = Projectiles({
        mounted = {}
    })
	io.stderr:write("[DEBUG] load(): weapon → " .. tostring(weapon) .. "\n")
io.stderr:write("[DEBUG] load(): mounted → " .. tostring(mounted) .. "\n")
io.stderr:write("[WARN] <<< Exiting load()\n")
end

function love.update(dt)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
    hero:update(dt)
    enemy:update(dt, hero)
    weapon:shoot(hero, enemy)
    weapon:shoot(enemy, hero)
    weapon:update(dt)
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function love.draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    hero:draw()
    enemy:draw()
    weapon:draw()
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end