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

	print(">>> Entering load()")
	print("load(): hero → " .. tostring(hero) .. "")
    enemy = Opponent({
        width = 64,
        height = 108,
        x = 400,
        y = 24,
        imagePath = '/assets/opponent.png'
    })

	print("load(): width → " .. tostring(width) .. "")
	print("load(): height → " .. tostring(height) .. "")
	print("load(): imagePath → " .. tostring(imagePath) .. "")
	print("load(): enemy → " .. tostring(enemy) .. "")
    weapon = Projectiles()
    weapon2 = Projectiles2()
end

function love.update(dt)
	print(">>> Entering update(dt=" .. tostring(dt) .. ")")
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
			print("update(dt=" .. tostring(dt) .. "): width → " .. tostring(width) .. "")
			print("update(dt=" .. tostring(dt) .. "): height → " .. tostring(height) .. "")
    end

    if (weapon2.canShoot) then
        weapon2:shoot(enemy, hero)
    end

    weapon:update(dt)
    weapon2:update(dt)
	print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function love.draw()
	print(">>> Entering draw()")
    hero:draw()
    enemy:draw()
    weapon:draw()
    weapon2:draw()
	print("<<< Exiting draw()")
end