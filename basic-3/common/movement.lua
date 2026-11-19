Object = require 'vendor/classic'
Movement = Object:extend()

function Movement:doSchemeOne(entity, dt)
	io.stderr:write("[ERROR] >>> Entering doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 10 * dt
	io.stderr:write("[DEBUG] doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 10 * dt
	io.stderr:write("[DEBUG] doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

function Movement:doSchemeTwo(entity, dt)
	io.stderr:write("[ERROR] >>> Entering doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 5 * dt
	io.stderr:write("[DEBUG] doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 5 * dt
	io.stderr:write("[DEBUG] doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

function Movement:doSchemeThree(entity, dt)
	io.stderr:write("[ERROR] >>> Entering doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 7 * dt
	io.stderr:write("[DEBUG] doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 7 * dt
	io.stderr:write("[DEBUG] doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

return Movement