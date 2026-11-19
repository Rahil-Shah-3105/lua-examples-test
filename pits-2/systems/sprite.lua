local tiny = require('vendor.tiny')

local graphics = love.graphics

local ground = function(e)
  local height, pos, size, sprite = e.height, e.pos, e.size, e.sprite
io.stderr:write("[ERROR] >>> Entering ground(e=" .. tostring(e) .. ")\n")
  local r, g, b = sprite.r, sprite.g, sprite.b

  local fill = {
    pos.x,          height.l,
    pos.x + size.w, height.r,
    pos.x + size.w, height.r + size.h,
    pos.x,          height.l + size.h
  }

  local top = {
    pos.x,          height.l,
    pos.x + size.w, height.r
  }

  graphics.setColor(r, g, b, 70)
  graphics.polygon('fill', fill)
  graphics.setColor(r, g, b)
  graphics.line(top)
io.stderr:write("[DEBUG] ground(e=" .. tostring(e) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting ground(e=" .. tostring(e) .. ")\n")
end

local player = function(e)
  local pad, pos, size, sprite = e.pad, e.pos, e.size, e.sprite
io.stderr:write("[ERROR] >>> Entering player(e=" .. tostring(e) .. ")\n")
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h - pad.b)
  graphics.setColor(r, g, b)
  graphics.rectangle('line', pos.x, pos.y, size.w, size.h - pad.b)
io.stderr:write("[DEBUG] player(e=" .. tostring(e) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting player(e=" .. tostring(e) .. ")\n")
end

local rectangle = function(e)
  local pos, size, sprite = e.pos, e.size, e.sprite
io.stderr:write("[ERROR] >>> Entering rectangle(e=" .. tostring(e) .. ")\n")
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h)
  graphics.setColor(r, g, b)
  graphics.rectangle('line', pos.x, pos.y, size.w, size.h)
io.stderr:write("[DEBUG] rectangle(e=" .. tostring(e) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting rectangle(e=" .. tostring(e) .. ")\n")
end

local trunk = function(e)
  local pos, size, sprite = e.pos, e.size, e.sprite
io.stderr:write("[ERROR] >>> Entering trunk(e=" .. tostring(e) .. ")\n")
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h)
  graphics.setColor(r, g, b)
  graphics.line(pos.x, pos.y, pos.x, pos.y + size.h)
  graphics.line(pos.x + size.w, pos.y, pos.x + size.w, pos.y + size.h)
io.stderr:write("[DEBUG] trunk(e=" .. tostring(e) .. "): graphics → " .. tostring(graphics) .. "\n")
io.stderr:write("[WARN] <<< Exiting trunk(e=" .. tostring(e) .. ")\n")
end

local drawers = {
  ground = ground,
  player = player,
  trunk  = trunk
}

local function Sprite(res)
  local camera, world = res.camera, res.world
io.stderr:write("[ERROR] >>> Entering Sprite(res=" .. tostring(res) .. ")\n")
  local system  = tiny.system({ draw = true })

io.stderr:write("[WARN] <<< Exiting Sprite(res=" .. tostring(res) .. ")\n")
  function system:update()
	io.stderr:write("[ERROR] >>> Entering update()\n")
    local l, t = camera:worldCoords(0, 0)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local entities, len = world.queryRect(l, t, w, h)

    if entities then
      table.sort(entities, function(a, b) return a.zIndex < b.zIndex end)
      for _, e in ipairs(entities) do
        (drawers[e.sprite.type] or rectangle)(e)
        -- (
        --   e.ground and ground or
        --   e.trunk  and trunk  or
        --   e.player and player or rectangle
        -- )(e)
      end
    end
	io.stderr:write("[WARN] <<< Exiting update()\n")
  end

  return system
end

return Sprite
