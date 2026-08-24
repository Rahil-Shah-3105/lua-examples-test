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

	print(">>> Entering load()")
	print("load(): hero → " .. tostring(hero) .. "")
    enemy = Opponent({
        width = 64,
        height = 108,
        x = 0,
        y = 0,
        imagePath = '/assets/opponent.png'
    })

	print("load(): width → " .. tostring(width) .. "")
	print("load(): height → " .. tostring(height) .. "")
    weapon = Projectiles({
        mounted = {}
    })
	print("load(): imagePath → " .. tostring(imagePath) .. "")
end

function love.update(dt)
	print(">>> Entering update(dt=" .. tostring(dt) .. ")")
    hero:update(dt)
    enemy:update(dt, hero)
    weapon:shoot(hero, enemy)
    weapon:shoot(enemy, hero)
    weapon:update(dt)
	print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function love.draw()
	print(">>> Entering draw()")
    hero:draw()
    enemy:draw()
    weapon:draw()
	print("<<< Exiting draw()")
end