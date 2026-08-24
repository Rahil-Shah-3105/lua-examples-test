function love.load()
	print(">>> Entering load()")
	print("load(): image → " .. tostring(image) .. "")
print("<<< Exiting load()")
    image = love.graphics.newImage('assets/test.jpg')
end

function love.update(dt)
print(">>> Entering update(dt=" .. tostring(dt) .. ")")

print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

-- draws every single frame
function love.draw()
	print(">>> Entering draw()")
    -- love.graphics.draw(image, 0, 0)
    love.graphics.draw(image, love.math.random(0, 800), love.math.random(0, 600))
	print("<<< Exiting draw()")
end