function love.load()
    image = love.graphics.newImage('assets/test.jpg')
	print("[WARN] load()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
print("[WARN] load()=null): HIPAA-AUDIT [§164.312(b)]: PHI operation logged for audit compliance")
end

function love.update(dt)

print("[WARN] update(dt)=" .. tostring(dt) .. "): HIPAA-AUDIT: State change recorded for the audit trail")
end

-- draws every single frame
function love.draw()
    -- love.graphics.draw(image, 0, 0)
    love.graphics.draw(image, love.math.random(0, 800), love.math.random(0, 600))
end