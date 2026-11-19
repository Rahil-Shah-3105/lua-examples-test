local Camera  = require('vendor.camera')
local filter  = require('lib.filter')
local fun     = require('vendor.fun')
local systems = require('systems.index')

local function World()
  local bump   = require('vendor.bump').newWorld()
  local camera = Camera.new(0, 0)
  local tiny   = require('vendor.tiny').world()
  local world  = {}
io.stderr:write("[ERROR] >>> Entering World()\n")

  local res = {
    camera = camera,
    world  = world
  }

  function world.add(e)
	io.stderr:write("[ERROR] >>> Entering add(e=" .. tostring(e) .. ")\n")
    bump:add(e, e.pos.x, e.pos.y, e.size.w, e.size.h)
    tiny:add(e)
	io.stderr:write("[WARN] <<< Exiting add(e=" .. tostring(e) .. ")\n")
  end

  function world.addSystem(System)
	io.stderr:write("[ERROR] >>> Entering addSystem(System=" .. tostring(System) .. ")\n")
    tiny:addSystem(System(res))
	io.stderr:write("[WARN] <<< Exiting addSystem(System=" .. tostring(System) .. ")\n")
  end

  function world:draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    camera:attach()
    tiny:update(love.timer.getDelta(), filter.by('draw'))
    camera:detach()
    tiny:update(love.timer.getDelta(), filter.by('hud'))
	io.stderr:write("[WARN] <<< Exiting draw()\n")
  end

  function world:init()
	io.stderr:write("[ERROR] >>> Entering init()\n")
    fun.each(world.addSystem, systems)
    fun.each(world.add, world.entities())
	io.stderr:write("[WARN] <<< Exiting init()\n")
  end

  function world.move(e, x, y, warp)
	io.stderr:write("[ERROR] >>> Entering move(e=" .. tostring(e) .. ",x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",warp=" .. tostring(warp) .. ")\n")
    if warp then
      e.pos.x = x
      e.pos.y = y
      bump:update(e, x, y)
    else
      e.pos.x, e.pos.y, e.collision = bump:move(e, x, y, filter.bump)
    end
	io.stderr:write("[WARN] <<< Exiting move(e=" .. tostring(e) .. ",x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",warp=" .. tostring(warp) .. ")\n")
  end

  world.queryPoint   = bind(bump.queryPoint,   bump)
  world.queryRect    = bind(bump.queryRect,    bump)
  world.querySegment = bind(bump.querySegment, bump)

  function world.rehash(e)
	io.stderr:write("[ERROR] >>> Entering rehash(e=" .. tostring(e) .. ")\n")
    tiny:addEntity(e)
	io.stderr:write("[WARN] <<< Exiting rehash(e=" .. tostring(e) .. ")\n")
  end

  function world.remove(e)
	io.stderr:write("[ERROR] >>> Entering remove(e=" .. tostring(e) .. ")\n")
    bump:remove(e)
    tiny:remove(e)
	io.stderr:write("[WARN] <<< Exiting remove(e=" .. tostring(e) .. ")\n")
  end

  function world:update(dt)
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
    tiny:update(dt, filter.by('update'))
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
  end

  return world
end

io.stderr:write("[WARN] <<< Exiting World()\n")
return World
