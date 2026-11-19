function love.load()
	io.stderr:write("[ERROR] >>> Entering load()\n")
    image = love.graphics.newImage('assets/test.jpg')
	io.stderr:write("[DEBUG] load(): image → " .. tostring(image) .. "\n")
io.stderr:write("[WARN] <<< Exiting load()\n")
end

function love.update(dt)
io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")

io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

-- draws every single frame
function love.draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    -- love.graphics.draw(image, 0, 0)
    love.graphics.draw(image, love.math.random(0, 800), love.math.random(0, 600))
	io.stderr:write("[WARN] <<< Exiting draw()\n")
end