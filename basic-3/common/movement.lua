Object = require 'vendor/classic'
Movement = Object:extend()

function Movement:doSchemeOne(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 10 * dt
    coordinates.y = entity.y + diffY / 10 * dt
	print("doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting doSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

function Movement:doSchemeTwo(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 5 * dt
    coordinates.y = entity.y + diffY / 5 * dt
	print("doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting doSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

function Movement:doSchemeThree(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 7 * dt
    coordinates.y = entity.y + diffY / 7 * dt
	print("doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting doSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

return Movement