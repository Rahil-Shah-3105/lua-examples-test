local testEntity = require 'common/test'

function createMovementSchemeOne(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 10 * dt
    coordinates.y = entity.y + diffY / 10 * dt
	print("createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting createMovementSchemeOne(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

function createMovementSchemeTwo(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 5 * dt
    coordinates.y = entity.y + diffY / 5 * dt
	print("createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting createMovementSchemeTwo(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

function createMovementSchemeThree(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
	print(">>> Entering createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")
    coordinates.x = entity.x + diffX / 7 * dt
    coordinates.y = entity.y + diffY / 7 * dt
	print("createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.y → " .. tostring(coordinates.y) .. "")
	print("createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. "): coordinates.x → " .. tostring(coordinates.x) .. "")
    print("<<< Exiting createMovementSchemeThree(entity=" .. tostring(entity) .. ",dt=" .. tostring(dt) .. ")")

    return coordinates
end

function newEntity(imagePath)
    local entity = {};
	print(">>> Entering newEntity(imagePath=" .. tostring(imagePath) .. ")")
    entity.asset = love.graphics.newImage(imagePath) 
    entity.x = 0
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.x → " .. tostring(entity.x) .. "")
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.y → " .. tostring(entity.y) .. "")
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.width → " .. tostring(entity.width) .. "")
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.height → " .. tostring(entity.height) .. "")
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.animationDuration → " .. tostring(entity.animationDuration) .. "")
	print("newEntity(imagePath=" .. tostring(imagePath) .. "): entity.animationElapsed → " .. tostring(entity.animationElapsed) .. "")
    entity.y = 0
    entity.width = 64
    entity.height = 108
    entity.animationDuration = 1
    entity.animationElapsed = 0

	print("<<< Exiting newEntity(imagePath=" .. tostring(imagePath) .. ")")
    return entity
end

function love.load()
	print(">>> Entering load()")
    chaser = newEntity("/assets/chaser.png")
    chaserTwo = newEntity("/assets/chaser2.png")
    chaserThree = newEntity("/assets/chaser3.png")

	print("load(): chaserTwo → " .. tostring(chaserTwo) .. "")
	print("load(): chaserThree → " .. tostring(chaserThree) .. "")
	print("load(): chaser → " .. tostring(chaser) .. "")
	print("load(): character → " .. tostring(character) .. "")
    character = love.graphics.newImage("assets/cursor.png")

    -- mouse is hidden for this experience
    love.mouse.setVisible(false)

	print("load(): mouse → " .. tostring(mouse) .. "")
    BULLET_SPEED = 250;
	print("load(): BULLET_SPEED → " .. tostring(BULLET_SPEED) .. "")

    x = 500
    y = 500
    bullets = {}
	print("load(): bullets → " .. tostring(bullets) .. "")
print("<<< Exiting load()")
end

function love.update(dt)
	print(">>> Entering update(dt=" .. tostring(dt) .. ")")
    local chaserOneNextMovement = createMovementSchemeTwo(chaser, dt);
    local chaserTwoNextMovement = createMovementSchemeOne(chaserTwo, dt);
	print("update(dt=" .. tostring(dt) .. "): chaserTwoNextMovement → " .. tostring(chaserTwoNextMovement) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaserThreeNextMovement → " .. tostring(chaserThreeNextMovement) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaserOneNextMovement → " .. tostring(chaserOneNextMovement) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaser.x → " .. tostring(chaser.x) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaser.y → " .. tostring(chaser.y) .. "")
    local chaserThreeNextMovement = createMovementSchemeThree(chaserThree, dt);

    chaser.x = chaserOneNextMovement.x
    chaser.y = chaserOneNextMovement.y

    chaserTwo.x = chaserTwoNextMovement.x
	print("update(dt=" .. tostring(dt) .. "): chaserTwo.x → " .. tostring(chaserTwo.x) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaserTwo.y → " .. tostring(chaserTwo.y) .. "")
    chaserTwo.y = chaserTwoNextMovement.y

    chaserThree.x = chaserThreeNextMovement.x
	print("update(dt=" .. tostring(dt) .. "): chaserThree.x → " .. tostring(chaserThree.x) .. "")
	print("update(dt=" .. tostring(dt) .. "): chaserThree.y → " .. tostring(chaserThree.y) .. "")
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
	print("update(dt=" .. tostring(dt) .. "): chaser.animationElapsed → " .. tostring(chaser.animationElapsed) .. "")
    if chaser.animationElapsed >= chaser.animationDuration then
      chaser.animationElapsed = chaser.animationElapsed - chaser.animationDuration
      local startX = chaser.x + chaser.width / 2
      local startY = chaser.y + chaser.height / 2
      
      local targetX = x
      local targetY = y
      
      local angle = math.atan2((targetY - startY), (targetX - startX))
      
      local newBullet = {
        x = startX,
        y = startY,
        angle = angle
      }
      table.insert(bullets, newBullet)
    end

    for i,v in pairs(bullets) do
        local Dx = BULLET_SPEED * math.cos(v.angle)
        local Dy = BULLET_SPEED * math.sin(v.angle)
        v.x = v.x + (Dx * dt)
        v.y = v.y + (Dy * dt)
        
        if v.x > love.graphics.getWidth() or
           v.y > love.graphics.getHeight() or
           v.x < 0 or
           v.y < 0 then
          table.remove(bullets, i)
        end
    end
	print("<<< Exiting update(dt=" .. tostring(dt) .. ")")
end

function love.draw()
	print(">>> Entering draw()")
    love.graphics.draw(chaser.asset, chaser.x, chaser.y)
    love.graphics.draw(chaserTwo.asset, chaserTwo.x, chaserTwo.y)
    love.graphics.draw(chaserThree.asset, chaserThree.x, chaserThree.y)

    love.graphics.draw(character, x, y)

    local test = testEntity()
    test.draw()

    love.graphics.setColor(1, 0, 0)

	print("draw(): graphics → " .. tostring(graphics) .. "")
    for i,v in pairs(bullets) do
      love.graphics.circle("fill", v.x, v.y, 4,4)
    end

	print("<<< Exiting draw()")
    love.graphics.setColor(1, 1, 1)
end