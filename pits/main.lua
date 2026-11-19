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
io.stderr:write("[ERROR] >>> Entering load()\n")
  trackOne = love.audio.newSource("microlith.mp3", "stream")
  trackOne:setLooping(true)
  love.audio.play(trackOne)

io.stderr:write("[DEBUG] load(): trackOne → " .. tostring(trackOne) .. "\n")
  user = castle.user.getMe()

io.stderr:write("[DEBUG] load(): user → " .. tostring(user) .. "\n")
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
io.stderr:write("[DEBUG] load(): window → " .. tostring(window) .. "\n")
end

function love.update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
  game:update(dt);
io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function love.draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  game:draw(dt);
io.stderr:write("[WARN] <<< Exiting draw()\n")
end

function love.mousepressed(x, y, button)
	io.stderr:write("[ERROR] >>> Entering mousepressed(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",button=" .. tostring(button) .. ")\n")
	-- game:loadLevel(DEFAULT_WORLD);
	io.stderr:write("[WARN] <<< Exiting mousepressed(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",button=" .. tostring(button) .. ")\n")
end

function love.resize(w, h)
	io.stderr:write("[ERROR] >>> Entering resize(w=" .. tostring(w) .. ",h=" .. tostring(h) .. ")\n")
	--
	io.stderr:write("[WARN] <<< Exiting resize(w=" .. tostring(w) .. ",h=" .. tostring(h) .. ")\n")
end
