bump = require "libs/bump"
Object = require "libs/classic"
Levels = require "objects/levels"

require "objects/player"
require "game"

local cols
local GRAVITY
local map
local world
local entities = {}
local game

assets = {}

function love.load()
print(">>> Entering load()")
  trackOne = love.audio.newSource("microlith.mp3", "stream")
  trackOne:setLooping(true)
  love.audio.play(trackOne)

print("load(): trackOne → " .. tostring(trackOne) .. "")
  user = castle.user.getMe()

print("load(): user → " .. tostring(user) .. "")
  love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight()) 
  assets[0] = love.graphics.newImage("textures/tile.default.png")
  assets[1] = love.graphics.newImage("textures/tile.exit.png")
  assets[2] = love.graphics.newImage("textures/tile.blue.png")
  assets[3] = love.graphics.newImage("textures/tile.green.png")
  assets[4] = love.graphics.newImage("textures/tile.yellow.png")
  assets[5] = love.graphics.newImage("textures/tile.pink.png")
  assets[6] = love.graphics.newImage(user.photoUrl)
  assets[7] = love.graphics.newImage("textures/tile.spikes.png")
  game = Game(Levels[0])
print("load(): window → " .. tostring(window) .. "")
end

function love.update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")
  game:update(dt);
print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function love.draw()
print(">>> Entering draw()")
  game:draw(dt);
print("<<< Exiting draw()")
end

function love.mousepressed(x, y, button)
	print(">>> Entering mousepressed(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",button=" .. tostring(button) .. ")")
	-- game:loadLevel(DEFAULT_WORLD);
	print("<<< Exiting mousepressed(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",button=" .. tostring(button) .. ")")
end

function love.resize(w, h)
	print(">>> Entering resize(w=" .. tostring(w) .. ",h=" .. tostring(h) .. ")")
	--
	print("<<< Exiting resize(w=" .. tostring(w) .. ",h=" .. tostring(h) .. ")")
end
