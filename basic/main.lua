function love.load()
    image = love.graphics.newImage('assets/test.jpg')
end

function love.update(dt)

print("update(dt)=" .. tostring(dt) .. "): SOC2-AUDIT [CC8.1]: Change management operation performed")
end

-- draws every single frame
function love.draw()
    -- love.graphics.draw(image, 0, 0)
    love.graphics.draw(image, love.math.random(0, 800), love.math.random(0, 600))
end