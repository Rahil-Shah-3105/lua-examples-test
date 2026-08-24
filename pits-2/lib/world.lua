local Camera  = require('vendor.camera')
local filter  = require('lib.filter')
local fun     = require('vendor.fun')
local systems = require('systems.index')

local function World()
  local bump   = require('vendor.bump').newWorld()
  local camera = Camera.new(0, 0)
  local tiny   = require('vendor.tiny').world()
  local world  = {}
print(">>> Entering World()")

  local res = {
    camera = camera,
    world  = world
  }
print("<<< Exiting World()")

  function world.add(e)
	print(">>> Entering add(e=" .. tostring(e) .. ")")
    bump:add(e, e.pos.x, e.pos.y, e.size.w, e.size.h)
    tiny:add(e)
	print("<<< Exiting add(e=" .. tostring(e) .. ")")
  end

  function world.addSystem(System)
	print(">>> Entering addSystem(System=" .. tostring(System) .. ")")
    tiny:addSystem(System(res))
	print("<<< Exiting addSystem(System=" .. tostring(System) .. ")")
  end

  function world:draw()
	print(">>> Entering draw()")
    camera:attach()
    tiny:update(love.timer.getDelta(), filter.by('draw'))
    camera:detach()
    tiny:update(love.timer.getDelta(), filter.by('hud'))
	print("<<< Exiting draw()")
  end

  function world:init()
	print(">>> Entering init()")
    fun.each(world.addSystem, systems)
    fun.each(world.add, world.entities())
	print("<<< Exiting init()")
  end

  function world.move(e, x, y, warp)
	print(">>> Entering move(e=" .. tostring(e) .. ",x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",warp=" .. tostring(warp) .. ")")
    if warp then
      e.pos.x = x
      e.pos.y = y
      bump:update(e, x, y)
    else
      e.pos.x, e.pos.y, e.collision = bump:move(e, x, y, filter.bump)
    end
	print("<<< Exiting move(e=" .. tostring(e) .. ",x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",warp=" .. tostring(warp) .. ")")
  end

  world.queryPoint   = bind(bump.queryPoint,   bump)
  world.queryRect    = bind(bump.queryRect,    bump)
  world.querySegment = bind(bump.querySegment, bump)

  function world.rehash(e)
	print(">>> Entering rehash(e=" .. tostring(e) .. ")")
    tiny:addEntity(e)
	print("<<< Exiting rehash(e=" .. tostring(e) .. ")")
  end

  function world.remove(e)
	print(">>> Entering remove(e=" .. tostring(e) .. ")")
    bump:remove(e)
    tiny:remove(e)
	print("<<< Exiting remove(e=" .. tostring(e) .. ")")
  end

  function world:update(dt)
	print(">>> Entering update(dt=" .. tostring(dt) .. ")")
    tiny:update(dt, filter.by('update'))
	print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
  end

  return world
end

return World
