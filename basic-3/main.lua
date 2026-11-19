local testEntity = require 'common/test'

function createMovementSchemeOne(entity, dt)
	io.stderr:write("[ERROR] >>> Entering createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 10 * dt
	io.stderr:write("[DEBUG] createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 10 * dt
	io.stderr:write("[DEBUG] createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

function createMovementSchemeTwo(entity, dt)
	io.stderr:write("[ERROR] >>> Entering createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 5 * dt
	io.stderr:write("[DEBUG] createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 5 * dt
	io.stderr:write("[DEBUG] createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

function createMovementSchemeThree(entity, dt)
	io.stderr:write("[ERROR] >>> Entering createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 7 * dt
	io.stderr:write("[DEBUG] createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "\n")
    coordinates.y = entity.y + diffY / 7 * dt
	io.stderr:write("[DEBUG] createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "\n")

	io.stderr:write("[WARN] <<< Exiting createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")\n")
    return coordinates
end

function newEntity(imagePath)
	io.stderr:write("[ERROR] >>> Entering newEntity(imagePath=" .. tostring(imagePath) .. ")\n")
    local entity = {};
    entity.asset = love.graphics.newImage(imagePath) 
    entity.x = 0
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.x → " .. tostring(entity.x) .. "\n")
    entity.y = 0
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.y → " .. tostring(entity.y) .. "\n")
    entity.width = 64
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.width → " .. tostring(entity.width) .. "\n")
    entity.height = 108
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.height → " .. tostring(entity.height) .. "\n")
    entity.animationDuration = 1
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.animationDuration → " .. tostring(entity.animationDuration) .. "\n")
    entity.animationElapsed = 0
	io.stderr:write("[DEBUG] newEntity(imagePath=" .. tostring(imagePath) .. "): entity.animationElapsed → " .. tostring(entity.animationElapsed) .. "\n")

	io.stderr:write("[WARN] <<< Exiting newEntity(imagePath=" .. tostring(imagePath) .. ")\n")
    return entity
end

function love.load()
	io.stderr:write("[ERROR] >>> Entering load()\n")
    chaser = newEntity("/assets/chaser.png")
    chaserTwo = newEntity("/assets/chaser2.png")
    chaserThree = newEntity("/assets/chaser3.png")

	io.stderr:write("[DEBUG] load(): chaserTwo → " .. tostring(chaserTwo) .. "\n")
	io.stderr:write("[DEBUG] load(): chaser → " .. tostring(chaser) .. "\n")
    character = love.graphics.newImage("assets/cursor.png")

	io.stderr:write("[DEBUG] load(): character → " .. tostring(character) .. "\n")
    -- mouse is hidden for this experience
    love.mouse.setVisible(false)

	io.stderr:write("[DEBUG] load(): mouse → " .. tostring(mouse) .. "\n")
    BULLET_SPEED = 250;
	io.stderr:write("[DEBUG] load(): BULLET_SPEED → " .. tostring(BULLET_SPEED) .. "\n")

    x = 500
    y = 500
    bullets = {}
	io.stderr:write("[DEBUG] load(): bullets → " .. tostring(bullets) .. "\n")
io.stderr:write("[WARN] <<< Exiting load()\n")
end

function love.update(dt)
    local chaserOneNextMovement = createMovementSchemeTwo(chaser, dt);
    local chaserTwoNextMovement = createMovementSchemeOne(chaserTwo, dt);
    local chaserThreeNextMovement = createMovementSchemeThree(chaserThree, dt);

    chaser.x = chaserOneNextMovement.x
    chaser.y = chaserOneNextMovement.y

    chaserTwo.x = chaserTwoNextMovement.x
    chaserTwo.y = chaserTwoNextMovement.y

    chaserThree.x = chaserThreeNextMovement.x
    chaserThree.y = chaserThreeNextMovement.y

    if love.keyboard.isDown("left") then
        x = x - 100 * dt
    end

    if love.keyboard.isDown("right") then
        x = x + 100 * dt
    end

    if love.keyboard.isDown("up") then
        y = y - 100 * dt
    end

    if love.keyboard.isDown("down") then
        y = y + 100 * dt
    end

    chaser.animationElapsed = chaser.animationElapsed + dt
    if chaser.animationElapsed >= chaser.animationDuration then
      chaser.animationElapsed = chaser.animationElapsed - chaser.animationDuration
      local startX = chaser.x + chaser.width / 2
      local startY = chaser.y + chaser.height / 2
      
      local targetX = x
      local targetY = y
      
      local angle = math.atan2((targetY - startY), (targetX - startX))
      
	io.stderr:write("[ERROR] >>> Entering update(dt=" .. tostring(dt) .. ")\n")
      local newBullet = {
        x = startX,
        y = startY,
        angle = angle
      }
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaser.x → " .. tostring(chaser.x) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaser.y → " .. tostring(chaser.y) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaserTwo.x → " .. tostring(chaserTwo.x) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaserTwo.y → " .. tostring(chaserTwo.y) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaserThree.x → " .. tostring(chaserThree.x) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaserThree.y → " .. tostring(chaserThree.y) .. "\n")
	io.stderr:write("[DEBUG] update(dt=" .. tostring(dt) .. "): chaser.animationElapsed → " .. tostring(chaser.animationElapsed) .. "\n")
      table.insert(bullets, newBullet)
    end

    for i,v in pairs(bullets) do
        local Dx = BULLET_SPEED * math.cos(v.angle)
        local Dy = BULLET_SPEED * math.sin(v.angle)
        v.x = v.x + (Dx * dt)
        v.y = v.y + (Dy * dt)
        
		io.stderr:write("[ERROR] update(dt=" .. tostring(dt) .. "): chaserOneNextMovement → " .. tostring(chaserOneNextMovement) .. "\n")
		io.stderr:write("[ERROR] update(dt=" .. tostring(dt) .. "): chaserTwoNextMovement → " .. tostring(chaserTwoNextMovement) .. "\n")
        if v.x > love.graphics.getWidth() or
           v.y > love.graphics.getHeight() or
           v.x < 0 or
           v.y < 0 then
		io.stderr:write("[ERROR] update(dt=" .. tostring(dt) .. "): chaserThreeNextMovement → " .. tostring(chaserThreeNextMovement) .. "\n")
          table.remove(bullets, i)
        end
    end
	io.stderr:write("[WARN] <<< Exiting update(dt=" .. tostring(dt) .. ")\n")
end

function love.draw()
	io.stderr:write("[ERROR] >>> Entering draw()\n")
    love.graphics.draw(chaser.asset, chaser.x, chaser.y)
    love.graphics.draw(chaserTwo.asset, chaserTwo.x, chaserTwo.y)
    love.graphics.draw(chaserThree.asset, chaserThree.x, chaserThree.y)

    love.graphics.draw(character, x, y)

    local test = testEntity()
    test.draw()

    love.graphics.setColor(1, 0, 0)

	io.stderr:write("[DEBUG] draw(): graphics → " .. tostring(graphics) .. "\n")
    for i,v in pairs(bullets) do
      love.graphics.circle("fill", v.x, v.y, 4,4)
    end

	io.stderr:write("[WARN] <<< Exiting draw()\n")
    love.graphics.setColor(1, 1, 1)
end