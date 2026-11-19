Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:create(imagePath)
	io.stderr:write("[ERROR] >>> Entering create(imagePath=" .. tostring(imagePath) .. ")\n")
    local entity_object = {};
    entity_object.asset = love.graphics.newImage(imagePath) 
    entity_object.x = 0
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.x → " .. tostring(entity_object.x) .. "\n")
    entity_object.y = 0
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.y → " .. tostring(entity_object.y) .. "\n")
    entity_object.width = 64
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.width → " .. tostring(entity_object.width) .. "\n")
    entity_object.height = 108
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.height → " .. tostring(entity_object.height) .. "\n")
    entity_object.animationDuration = 1
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.animationDuration → " .. tostring(entity_object.animationDuration) .. "\n")
    entity_object.animationElapsed = 0
	io.stderr:write("[DEBUG] create(imagePath=" .. tostring(imagePath) .. "): entity_object.animationElapsed → " .. tostring(entity_object.animationElapsed) .. "\n")

	io.stderr:write("[WARN] <<< Exiting create(imagePath=" .. tostring(imagePath) .. ")\n")
    return entity
end

return Entity