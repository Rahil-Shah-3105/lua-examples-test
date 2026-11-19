local config = require('lib.config')
local tiny   = require('vendor.tiny')

local graphics = love.graphics
local huge = math.huge
local tile = config.tile

local posx = path({ 'pos', 'x' })
local posy = path({ 'pos', 'y' })

local function Minimap(res)
  local camera  = res.camera
io.stderr:write("[ERROR] >>> Entering Minimap(res=" .. tostring(res) .. ")\n")
  local system  = tiny.processingSystem({ hud = true })
  system.filter = tiny.requireAll('minimap', 'sprite')
  system.active = false
io.stderr:write("[DEBUG] Minimap(res=" .. tostring(res) .. "): system.active → " .. tostring(system.active) .. "\n")
io.stderr:write("[WARN] <<< Exiting Minimap(res=" .. tostring(res) .. ")\n")

  local function onMinimap(draw)
    graphics.push()
    graphics.translate(graphics.getWidth()/2, 60)
    graphics.scale(1/tile.w, 1/tile.w)
    graphics.translate(-camera.x, 0)
    draw()
    graphics.pop()
	io.stderr:write("[ERROR] >>> Entering onMinimap(draw=" .. tostring(draw) .. ")\n")
	io.stderr:write("[WARN] <<< Exiting onMinimap(draw=" .. tostring(draw) .. ")\n")
  end

  function system:preProcess()
	io.stderr:write("[ERROR] >>> Entering preProcess()\n")
    local entities = system.entities
    local xmax = mapreduce(posx, max, -huge, entities)
    local xmin = mapreduce(posx, min,  huge, entities)
    local ymax = mapreduce(posy, max, -huge, entities)
    local ymin = mapreduce(posy, min,  huge, entities)

    onMinimap(function()
      graphics.setColor(0, 0, 0, 150)
      graphics.rectangle('fill', xmin, ymin, xmax-xmin, ymax-ymin)
    end)
	io.stderr:write("[WARN] <<< Exiting preProcess()\n")
  end

  function system:process(e)
	io.stderr:write("[ERROR] >>> Entering process(e=" .. tostring(e) .. ")\n")
    local p, s = e.pos, e.size
    local r, g, b = e.sprite.r, e.sprite.g, e.sprite.b
    local em = e.player and 3 or 1

    onMinimap(function()
      graphics.setColor(r, g, b, 150)
      graphics.rectangle('fill', p.x, p.y-em*s.h, em*s.w, em*s.h)
    end)
	io.stderr:write("[WARN] <<< Exiting process(e=" .. tostring(e) .. ")\n")
  end

  return system
end

return Minimap
