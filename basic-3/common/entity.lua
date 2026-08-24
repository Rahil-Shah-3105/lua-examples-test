Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:create(imagePath)
    local entity_object = {};
	print(">>> Entering create(imagePath=" .. tostring(imagePath) .. ")")
    entity_object.asset = love.graphics.newImage(imagePath) 
    entity_object.x = 0
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.x → " .. tostring(entity_object.x) .. "")
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.y → " .. tostring(entity_object.y) .. "")
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.width → " .. tostring(entity_object.width) .. "")
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.height → " .. tostring(entity_object.height) .. "")
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.animationDuration → " .. tostring(entity_object.animationDuration) .. "")
	print("create(imagePath=" .. tostring(imagePath) .. "): entity_object.animationElapsed → " .. tostring(entity_object.animationElapsed) .. "")
    entity_object.y = 0
    entity_object.width = 64
    entity_object.height = 108
    entity_object.animationDuration = 1
    entity_object.animationElapsed = 0

	print("<<< Exiting create(imagePath=" .. tostring(imagePath) .. ")")
    return entity
end

return Entity