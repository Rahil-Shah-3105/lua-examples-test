local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'
local Projectiles2 = require 'common/projectiles2'

function love.load()
	io.stderr:write("[ERROR] >>> Entering load()\n")
    hero = Entity({
        width = 32,
        height = 48,
        x = 400,
        y = 400,
        imagePath = '/assets/entity.png'
    })

	io.stderr:write("[DEBUG] load(): hero → " .. tostring(hero) .. "\n")
    enemy = Opponent({
        width = 64,
        height = 108,
        x = 400,
        y = 24,
        imagePath = '/assets/opponent.png'
    })

	io.stderr:write("[DEBUG] load(): enemy → " .. tostring(enemy) .. "\n")
    weapon = Projectiles()
    weapon2 = Projectiles2()
	io.stderr:write("[DEBUG] load(): weapon → " .. tostring(weapon) .. "\n")
	io.stderr:write("[DEBUG] load(): weapon2 → " .. tostring(weapon2) .. "\n")
	io.stderr:write("[WARN] <<< Exiting load()\n")
end

function love.update(dt)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
    hero:update(dt)
    enemy:update(dt, hero)

    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()

        if weapon.canShoot then
            weapon:shoot(hero, { 
                x = x, 
                y = y, 
                width = 2, 
                height = 2 
            })
        end
    end

    if (weapon2.canShoot) then
        weapon2:shoot(enemy, hero)
    end

    weapon:update(dt)
    weapon2:update(dt)
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function love.draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    hero:draw()
    enemy:draw()
    weapon:draw()
    weapon2:draw()
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end